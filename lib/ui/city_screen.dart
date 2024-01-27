
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoder_plus/geocoder_plus.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:weather_app/providers.dart';

import '../data/models/current_forecast_response.dart';
import '../misc.dart';
import '../network/model_response.dart';
import '../viewmodels/location_viewmodel.dart';
import 'add_city_dialog.dart';

class CityInfo {
  final String name;
  Address? location;
  CurrentForecastResponse? currentForecast;

  CityInfo(this.name);
}

@RoutePage()
class CityScreen extends ConsumerStatefulWidget {
  const CityScreen({super.key});

  @override
  ConsumerState<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends ConsumerState<CityScreen> {
  final cities = <CityInfo>[];
  TemperatureUnit currentUnit = TemperatureUnit.fahrenheit;
  late LocationViewModel locationViewModel;

  @override
  void initState() {
    super.initState();
    locationViewModel = ref.read(locationViewModelProvider.notifier);
    currentUnit = locationViewModel.currentUnit;
    updateCityLocations();
  }

  void updateCurrentUnit() {
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs.containsKey('temperatureUnit')) {
      final unit = prefs.getString('temperatureUnit');
      if (unit == 'celsius') {
        currentUnit = TemperatureUnit.celsius;
      } else {
        currentUnit = TemperatureUnit.fahrenheit;
      }
    }
    setState(() {});
  }

  Future updateCityLocations() async {
    updateCurrentUnit();
    for (final city in cities) {
      if (city.location == null) {
        final location =
            await locationViewModel.getLocationFromAddress(city.name);
        city.location = (location).first;
        if (city.location != null) {
          final response = await locationViewModel.getCurrentForecast(
              city.location!.coordinates.latitude,
              city.location!.coordinates.longitude,
              DateTime.now().timeZoneName,
              currentUnit.name);
          final result = response.body;
          if (result is Success<CurrentForecastResponse>) {
            city.currentForecast = result.value;
          }
        }
            }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddCityDialog(context, (city) {
            if (city != null && city.isNotEmpty) {
              cities.add(CityInfo(city));
              saveCities(cities);
              updateCityLocations();
              setState(() {});
            }
          });
        },
        mini: true,
        foregroundColor: Colors.white,
        heroTag: null,
        tooltip: 'Add City',
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              colors: [Color(0xff42C8F9), Color(0xffFFCF90)]),
        ),
        child: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) {
            var cityName = cities[index].name;
            if (cities[index].currentForecast != null) {
              cityName += ' ';
              cityName += cities[index].currentForecast!.getWeatherString();
            }
            return ListTile(
              title: Text(
                cityName,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  cities.removeAt(index);
                  saveCities(cities);
                  setState(() {});
                },
              ),
            );
          },
        ),
      ),
    ));
  }

  void saveCities(List<CityInfo> cities) {
    ref
        .read(sharedPreferencesProvider)
        .setStringList('cities', cities.map((e) => e.name).toList());
  }
}
