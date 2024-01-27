class DailyForecastResponse {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  DailyUnits? dailyUnits;
  Daily? daily;

  DailyForecastResponse(
      {latitude,
        this.longitude,
        this.generationtimeMs,
        this.utcOffsetSeconds,
        this.timezone,
        this.timezoneAbbreviation,
        this.elevation,
        this.dailyUnits,
        this.daily});

  DailyForecastResponse.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    dailyUnits = json['daily_units'] != null
        ? DailyUnits.fromJson(json['daily_units'])
        : null;
    daily = json['daily'] != null ? Daily.fromJson(json['daily']) : null;
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
    if (dailyUnits != null) {
      data['daily_units'] = dailyUnits!.toJson();
    }
    if (daily != null) {
      data['daily'] = daily!.toJson();
    }
    return data;
  }
}

class DailyUnits {
  String? time;
  String? weatherCode;
  String? windSpeed10mMax;
  String? windGusts10mMax;

  DailyUnits(
      {this.time,
        this.weatherCode,
        this.windSpeed10mMax,
        this.windGusts10mMax});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    weatherCode = json['weather_code'];
    windSpeed10mMax = json['wind_speed_10m_max'];
    windGusts10mMax = json['wind_gusts_10m_max'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time'] = time;
    data['weather_code'] = weatherCode;
    data['wind_speed_10m_max'] = windSpeed10mMax;
    data['wind_gusts_10m_max'] = windGusts10mMax;
    return data;
  }
}

class Daily {
  List<String>? time;
  List<int>? weatherCode;
  List<double>? windSpeed10mMax;
  List<double>? windGusts10mMax;

  Daily(
      {this.time,
        this.weatherCode,
        this.windSpeed10mMax,
        this.windGusts10mMax});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    weatherCode = json['weather_code'].cast<int>();
    windSpeed10mMax = json['wind_speed_10m_max'].cast<double>();
    windGusts10mMax = json['wind_gusts_10m_max'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time'] = time;
    data['weather_code'] = weatherCode;
    data['wind_speed_10m_max'] = windSpeed10mMax;
    data['wind_gusts_10m_max'] = windGusts10mMax;
    return data;
  }
}
