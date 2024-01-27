// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WeatherService extends WeatherService {
  _$WeatherService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WeatherService;

  @override
  Future<Response<Result<DailyForecastResponse>>> dailyForecast(
    double latitude,
    double longitude,
    String timezone,
    String unit,
  ) {
    final Uri $url = Uri.parse(
        'v1/forecast?daily=weather_code,wind_speed_10m_max,wind_gusts_10m_max');
    final Map<String, dynamic> $params = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'temperature_unit': unit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<Result<DailyForecastResponse>, DailyForecastResponse>($request);
  }

  @override
  Future<Response<Result<CurrentForecastResponse>>> currentForecast(
    double latitude,
    double longitude,
    String timezone,
    String unit,
  ) {
    final Uri $url = Uri.parse(
        'v1/forecast?current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m');
    final Map<String, dynamic> $params = <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'temperature_unit': unit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Result<CurrentForecastResponse>,
        CurrentForecastResponse>($request);
  }
}
