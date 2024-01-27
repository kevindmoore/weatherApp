import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/models/current_forecast_response.dart';
import 'data/models/location_state.dart';
import 'location/location_manager.dart';
import 'network/weather_service.dart';
import 'router/app_routes.dart';
import 'viewmodels/location_viewmodel.dart';

final routeProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});

final locationProvider = Provider<LocationManager>((ref) {
  return LocationManager();
});

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService.create();
});

final locationViewModelProvider = StateNotifierProvider<LocationViewModel, LocationState>((ref) {
  return LocationViewModel(ref.read(weatherServiceProvider), ref.read(locationProvider), ref.read(sharedPreferencesProvider));
});


late SharedPreferences globalSharedPreferences;

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  return globalSharedPreferences;
});
