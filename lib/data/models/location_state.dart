import 'package:freezed_annotation/freezed_annotation.dart';

import '../../misc.dart';
import 'current_forecast_response.dart';
import 'daily_forecast_response.dart';

part 'location_state.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState(
      {@Default(TemperatureUnit.fahrenheit) TemperatureUnit currentUnit,
      String? currentLocation,
      CurrentForecastResponse? currentForecast,
      DailyForecastResponse? dailyForecast}) = _LocationState;
}
