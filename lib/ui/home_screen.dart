import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:weather_app/data/models/current_forecast_response.dart';
import 'package:weather_app/providers.dart';

import '../data/models/location_state.dart';
import '../misc.dart';
import '../viewmodels/location_viewmodel.dart';

const int checkActiveMinutes = 1; // 1 minute

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var locationEnabled = false;

  String? currentLocation;
  LocationState locationState = const LocationState();

  TemperatureUnit currentUnit = TemperatureUnit.fahrenheit;
  Timer? timer;
  late LocationViewModel locationViewModel;

  @override
  void initState() {
    super.initState();
    startup();
  }

  Future startup() async {
    locationViewModel = ref.read(locationViewModelProvider.notifier);
    await locationViewModel.checkLocationPermissions();
    currentUnit = locationViewModel.currentUnit;
    locationEnabled = locationViewModel.locationEnabled;
    getCurrentWeather();
    startTimer();
  }

  Future getCurrentWeather() async {
    await locationViewModel.getWeather();
    currentLocation = locationViewModel.currentLocation;
    setState(() {});
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  void startTimer() {
    cancelTimer();
    timer ??=
        Timer(const Duration(minutes: checkActiveMinutes), onTimerFinished);
  }

  void cancelTimer() {
    timer?.cancel();
    timer = null;
  }

  void onTimerFinished() {
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs.containsKey('temperatureUnit')) {
      final unit = prefs.getString('temperatureUnit');
      if (unit == 'celsius') {
        currentUnit = TemperatureUnit.celsius;
      } else {
        currentUnit = TemperatureUnit.fahrenheit;
      }
    }
    getCurrentWeather();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    if (!locationEnabled) {
      return const Scaffold(
        body: Center(
          child: Text('Location is not enabled'),
        ),
      );
    }
    locationState = ref.watch(locationViewModelProvider);
    final currentForecast = locationState.currentForecast;
    final dailyForecast = locationState.dailyForecast;

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              colors: [Color(0xff42C8F9), Color(0xffFFCF90)]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentLocation ?? '',
                style: cityNameStyle,
              ),
              const SizedBox(height: 16),
              if (currentForecast != null && currentForecast.current != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentForecast.getWeatherString(),
                      style: temperatureStyle,
                    ),
                    Text(
                      'Wind Speed: ${currentForecast.getWindSpeedString()}',
                      style: cityNameStyle,
                    ),
                    Text(
                      'Humidity: ${currentForecast.getHumidityString()}',
                      style: cityNameStyle,
                    ),
                    Text(
                      locationViewModel.getWeatherDescription() ?? '',
                      style: cityNameStyle,
                    ),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: locationViewModel.getWeatherImage() ?? '',
                        alignment: Alignment.topCenter,
                        fit: BoxFit.contain,
                        height: 150,
                        width: 200,
                      ),
                    ),
                  ],
                ),
              if (dailyForecast != null &&
                  dailyForecast.daily != null &&
                  dailyForecast.daily!.time != null)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dailyForecast.daily!.time!.length,
                      itemBuilder: (context, index) {
                        final timeString = dailyForecast.daily!.time![index];
                        final weatherCode =
                            dailyForecast.daily!.weatherCode![index];
                        final wind =
                            dailyForecast.daily!.windSpeed10mMax![index];
                        final windUnit =
                            dailyForecast.dailyUnits!.windSpeed10mMax ?? 'km/h';
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dateStringToDayString(timeString),
                                    style: smallDateStyle),
                                const SizedBox(height: 8),
                                Text(
                                    locationViewModel
                                            .getWeatherDescriptionForCode(
                                                weatherCode) ??
                                        '',
                                    style: smallDateStyle),
                                const SizedBox(height: 8),
                                Text(
                                    locationViewModel.getWindSpeedString(
                                            wind, windUnit) ??
                                        '',
                                    style: smallDateStyle),
                              ],
                            ));
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
