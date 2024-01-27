/*
  "0": {
    "day": {
      "description": "Sunny",
      "image": "http://openweathermap.org/img/wn/01d@2x.png"
    },
    "night": {
      "description": "Clear",
      "image": "http://openweathermap.org/img/wn/01n@2x.png"
    }

 */

import 'dart:convert';

import 'package:flutter/services.dart';

/// These classes are used to parse the weather.json file. This file is then used for the image of the weather
/// as the Open Meteo API does not provide the image.
class WeatherCodes {
  Map<String, WeatherCode> codes = {};

  /// Find the weather description for the given code and time of day.
  String? getWeatherDescription(String code, bool isDay) {
    final weatherCode = codes[code];
    if (weatherCode == null) {
      return null;
    }
    final weatherDayNight = isDay ? weatherCode.weatherDayNight.day : weatherCode.weatherDayNight.night;
    return weatherDayNight.description;
  }

  String? getWeatherImage(String code, bool isDay) {
    final weatherCode = codes[code];
    if (weatherCode == null) {
      return null;
    }
    final weatherDayNight = isDay ? weatherCode.weatherDayNight.day : weatherCode.weatherDayNight.night;
    return weatherDayNight.image;
  }
}

class WeatherCode {
  final String code;
  final WeatherDayNight weatherDayNight;

  WeatherCode(this.code, this.weatherDayNight);
}

class WeatherDayNight {
  final WeatherDescription day;
  final WeatherDescription night;

  WeatherDayNight(this.day, this.night);
}

class WeatherDescription {
  final String description;
  final String image;

  WeatherDescription(this.description, this.image);
}

Future<WeatherCodes> loadWeatherCodes() async {
  final jsonString = await rootBundle.loadString('assets/weather.json');
  final weatherMap = jsonDecode(jsonString) as Map<String, dynamic>;
  final weatherCodes = WeatherCodes();
  for (final key in weatherMap.keys) {
    final weatherCodeMap = weatherMap[key] as Map<String, dynamic>;
    final day = weatherCodeMap['day'] as Map<String, dynamic>;
    final night = weatherCodeMap['night'] as Map<String, dynamic>;
    final dayDescription = WeatherDescription(
        day['description'] as String, day['image'] as String);
    final nightDescription = WeatherDescription(
        night['description'] as String, night['image'] as String);
    final weatherDayNight = WeatherDayNight(dayDescription, nightDescription);
    final code = WeatherCode(key, weatherDayNight);
    weatherCodes.codes[key] = code;
  }

  return weatherCodes;
}
