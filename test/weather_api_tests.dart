import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/models/current_forecast_response.dart';
import 'package:weather_app/data/models/daily_forecast_response.dart';
import 'package:weather_app/network/model_response.dart';
import 'package:weather_app/network/weather_service.dart';

void main() {
  test('Test Weather API for daily Forecast', () async {
    // latitude=52.52&longitude=13.41&daily=weather_code,wind_speed_10m_max,wind_gusts_10m_max&timezone=America%2FLos_Angeles
    final response = await WeatherService.create()
        .dailyForecast(52.52, 13.4198, 'America/Los_Angeles', 'celsius');
    expect(response, isNotNull, reason: 'Response is null');
    expect(response.body is Success<DailyForecastResponse>, isTrue,
        reason: 'Response is not Success<DailyForecastResponse>');
    final forecast = (response.body as Success<DailyForecastResponse>).value;
    expect(forecast.latitude, equals(52.52), reason: 'Lattitude is not 52.52');
    expect(forecast.longitude?.ceil(), equals(14),
        reason: 'longitude is not 14');
    expect(forecast.daily?.time?.length, equals(7),
        reason: 'Daily time length is not 7');
    expect(forecast.daily?.weatherCode?.length, equals(7),
        reason: 'Daily weather code length is not 7');
    expect(forecast.daily?.windGusts10mMax?.length, equals(7),
        reason: 'Daily windGusts10mMax length is not 7');
    expect(forecast.daily?.windSpeed10mMax?.length, equals(7),
        reason: 'Daily windSpeed10mMax length is not 7');
  });
  
  test('Test Weather API for Current Forecast', () async {
    // latitude=52.52&longitude=13.41&daily=weather_code,wind_speed_10m_max,wind_gusts_10m_max&timezone=America%2FLos_Angeles
    final response = await WeatherService.create()
        .currentForecast(52.52, 13.41998, 'America/Los_Angeles', 'celsius');
    expect(response, isNotNull, reason: 'Response is null');
    expect(response.body is Success<CurrentForecastResponse>, isTrue,
        reason: 'Response is not Success<CurrentForecastResponse>');
    final forecast = (response.body as Success<CurrentForecastResponse>).value;
    expect(forecast.latitude, equals(52.52), reason: 'Lattitude is not 52.52');
    expect(forecast.longitude?.ceil(), equals(14),
        reason: 'longitude is not 14');
    expect(forecast.current?.time, isNotNull, reason: 'Current time is null');
    expect(forecast.current?.interval, isNotNull,
        reason: 'Current interval is null');
    expect(forecast.current?.temperature2m, isNotNull,
        reason: 'Current temperature2m is null');
    expect(forecast.current?.relativeHumidity2m, isNotNull,
        reason: 'Current relativeHumidity2m is null');
    expect(forecast.current?.weatherCode, isNotNull,
        reason: 'Current weatherCode is null');
    expect(forecast.current?.windSpeed10m, isNotNull,
        reason: 'Current windSpeed10m is null');
  });
}
