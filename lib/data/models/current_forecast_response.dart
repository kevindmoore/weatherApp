class CurrentForecastResponse {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentUnits? currentUnits;
  Current? current;

  CurrentForecastResponse(
      {this.latitude,
        this.longitude,
        this.generationtimeMs,
        this.utcOffsetSeconds,
        this.timezone,
        this.timezoneAbbreviation,
        this.elevation,
        this.currentUnits,
        this.current});

  CurrentForecastResponse.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    currentUnits = json['current_units'] != null
        ? CurrentUnits.fromJson(json['current_units'])
        : null;
    current =
    json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['generationtime_ms'] = generationtimeMs;
    data['utc_offset_seconds'] = utcOffsetSeconds;
    data['timezone'] = timezone;
    data['timezone_abbreviation'] = timezoneAbbreviation;
    data['elevation'] = elevation;
    if (currentUnits != null) {
      data['current_units'] = currentUnits!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}

class CurrentUnits {
  String? time;
  String? interval;
  String? temperature2m;
  String? relativeHumidity2m;
  String? weatherCode;
  String? windSpeed10m;

  CurrentUnits(
      {time,
        this.interval,
        this.temperature2m,
        this.relativeHumidity2m,
        this.weatherCode,
        this.windSpeed10m});

  CurrentUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    interval = json['interval'];
    temperature2m = json['temperature_2m'];
    relativeHumidity2m = json['relative_humidity_2m'];
    weatherCode = json['weather_code'];
    windSpeed10m = json['wind_speed_10m'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time'] = time;
    data['interval'] = interval;
    data['temperature_2m'] = temperature2m;
    data['relative_humidity_2m'] = relativeHumidity2m;
    data['weather_code'] = weatherCode;
    data['wind_speed_10m'] = windSpeed10m;
    return data;
  }
}

class Current {
  String? time;
  int? interval;
  double? temperature2m;
  int? relativeHumidity2m;
  int? weatherCode;
  double? windSpeed10m;

  Current(
      {this.time,
        this.interval,
        this.temperature2m,
        this.relativeHumidity2m,
        this.weatherCode,
        this.windSpeed10m});

  Current.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    interval = json['interval'];
    temperature2m = json['temperature_2m'];
    relativeHumidity2m = json['relative_humidity_2m'];
    weatherCode = json['weather_code'];
    windSpeed10m = json['wind_speed_10m'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time'] = time;
    data['interval'] = interval;
    data['temperature_2m'] = temperature2m;
    data['relative_humidity_2m'] = relativeHumidity2m;
    data['weather_code'] = weatherCode;
    data['wind_speed_10m'] = windSpeed10m;
    return data;
  }
}

extension ForecastExtension on CurrentForecastResponse {
  String getWeatherString() {
    return '${current!.temperature2m!.toString()}${currentUnits?.temperature2m}';
  }
  String getWindSpeedString() {
    return '${current!.windSpeed10m!.toString()} ${currentUnits?.windSpeed10m}';
  }
  String getHumidityString() {
    return '${current!.relativeHumidity2m!.toString()}${currentUnits?.relativeHumidity2m}';
  }
}