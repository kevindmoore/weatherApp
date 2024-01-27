import 'package:chopper/chopper.dart';

import '../data/models/current_forecast_response.dart';
import '../data/models/daily_forecast_response.dart';
import 'model_response.dart';
import 'weather_converter.dart';

part 'weather_service.chopper.dart';

const String apiUrl = 'https://api.open-meteo.com/';

@ChopperApi()
abstract class WeatherService extends ChopperService {
  /// Get the details of a specific recipe
  @Get(
      path:
          'v1/forecast?daily=weather_code,wind_speed_10m_max,wind_gusts_10m_max')
  Future<Response<Result<DailyForecastResponse>>> dailyForecast(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('timezone') String timezone,
    @Query('temperature_unit') String unit,
  );

  // https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m&timezone=America%2FLos_Angeles
  @Get(
      path:
          'v1/forecast?current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m')
  Future<Response<Result<CurrentForecastResponse>>> currentForecast(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('timezone') String timezone,
    @Query('temperature_unit') String unit,
  );

  static WeatherService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(apiUrl),
      interceptors: [HttpLoggingInterceptor()],
      converter: WeatherConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$WeatherService(),
      ],
    );
    return _$WeatherService(client);
  }
}
