import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoder_plus/geocoder_plus.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/current_forecast_response.dart';
import '../data/models/daily_forecast_response.dart';
import '../data/models/location_state.dart';
import '../data/models/weather_codes.dart';
import '../location/location_manager.dart';
import '../misc.dart';
import '../network/model_response.dart';
import '../network/weather_service.dart';

class LocationViewModel extends StateNotifier<LocationState> {
  final WeatherService _weatherService;
  final LocationManager _locationManager;
  final SharedPreferences _sharedPreferences;
  var locationEnabled = false;
  CurrentForecastResponse? currentForecast;
  String? currentLocation;
  WeatherCodes? weatherCodes;
  TemperatureUnit currentUnit = TemperatureUnit.fahrenheit;

  LocationViewModel(
      this._weatherService, this._locationManager, this._sharedPreferences)
      : super(const LocationState()) {
    if (_sharedPreferences.containsKey('temperatureUnit')) {
      final unit = _sharedPreferences.getString('temperatureUnit');
      if (unit == 'celsius') {
        currentUnit = TemperatureUnit.celsius;
      }
    }
    loadCodes();
  }

  Future loadCodes() async {
    weatherCodes = await loadWeatherCodes();
  }

  Future checkLocationPermissions() async {
    if (!await _locationManager.hasPermission()) {
      return;
    }
    locationEnabled = await _locationManager.isLocationEnabled();
  }

  Future getWeather() async {
    await getCurrentWeather();
    await getDailyWeather();
  }

  Future getCurrentWeather() async {
    if (!locationEnabled) {
      return;
    }
    final location = await _locationManager.getLocation();
    final response = await _weatherService.currentForecast(location.latitude,
        location.longitude, DateTime.now().timeZoneName, currentUnit.name);
    final result = response.body;
    if (result is Success<CurrentForecastResponse>) {
      final body = result.value;
      currentForecast = body;
      state = state.copyWith(currentForecast: currentForecast);

      final addressList = await _locationManager.getAddressFromLocation(
          Coordinates(location.latitude, location.longitude));
      if (addressList.isNotEmpty) {
        currentLocation = addressList[0].locality;
      }
      state = state.copyWith(
          currentForecast: currentForecast, currentLocation: currentLocation);
    } else {
      logMessage('Problems getting Forecast $result');
    }
  }

  Future getCurrentForecast(
      double latitude, double longitude, String timezone, String unit) async {
    if (!locationEnabled) {
      return;
    }
    return _weatherService.currentForecast(latitude, longitude, timezone, unit);
  }

  Future getDailyWeather() async {
    if (!locationEnabled) {
      return;
    }
    final location = await _locationManager.getLocation();
    final response = await _weatherService.dailyForecast(location.latitude,
        location.longitude, DateTime.now().timeZoneName, currentUnit.name);
    final result = response.body;
    if (result is Success<DailyForecastResponse>) {
      final body = result.value;
      state = state.copyWith(dailyForecast: body);
    } else {
      logMessage('Problems getting Forecast $result');
    }
  }

  Future<List<Address>> getLocationFromAddress(String address) async {
    return _locationManager.getLocationFromAddress(address);
  }

  String? getWeatherDescription() {
    if (currentForecast == null || weatherCodes == null) {
      return null;
    }
    return weatherCodes!.getWeatherDescription(
        currentForecast!.current!.weatherCode.toString(), true);
  }

  String getWindSpeedString(double speed, String unit) {
    return '${speed.toString()} $unit';
  }

  String? getWeatherDescriptionForCode(int code) {
    if (weatherCodes == null) {
      return null;
    }
    return weatherCodes!.getWeatherDescription(code.toString(), true);
  }

  String? getWeatherImage() {
    if (currentForecast == null || weatherCodes == null) {
      return null;
    }
    return weatherCodes!.getWeatherImage(
        currentForecast!.current!.weatherCode.toString(), true);
  }
}
