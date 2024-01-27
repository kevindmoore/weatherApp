import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import '../data/models/current_forecast_response.dart';
import '../data/models/daily_forecast_response.dart';
import 'model_response.dart';

class WeatherConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );

    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    final contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  /// Take the JSON data and convert to models
  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      final mapData = json.decode(body) as Map<String, dynamic>;

      // This is the daily forecast
      if (mapData.keys.contains('daily')) {
        final forecastResponse = DailyForecastResponse.fromJson(mapData);
        return response.copyWith<BodyType>(
          body: Success(forecastResponse) as BodyType,
        );
      } else {
        // This is the current Forecast

        final forecastResponse = CurrentForecastResponse.fromJson(mapData);

        return response.copyWith<BodyType>(
          body: Success(forecastResponse) as BodyType,
        );
      }
    } catch (e) {
      chopperLogger.warning(e);
      final error = Error<InnerType>(Exception(e.toString()));
      return Response(response.base, null,
          error: error);
    }
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }
}