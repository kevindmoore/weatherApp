import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var cityNameStyle = const TextStyle(
    fontWeight: FontWeight.w700, fontSize: 18, color: Colors.white);

var temperatureStyle = const TextStyle(
    fontWeight: FontWeight.w900, fontSize: 64, color: Colors.white);

var smallTemperatureStyle = const TextStyle(
    fontWeight: FontWeight.w900, fontSize: 22, color: Colors.white);

var smallDateStyle = const TextStyle(
    fontWeight: FontWeight.w900, fontSize: 12, color: Colors.white);

var screenTitleStyle = const TextStyle(
    fontWeight: FontWeight.w900, fontSize: 36, color: Colors.white);

enum TemperatureUnit { celsius, fahrenheit }

final weekDayFormat = DateFormat('EEE');
final monthDayYearFormat = DateFormat('yyyy-MM-dd');

String dateStringToDayString(String date) {
  final dateTime = monthDayYearFormat.parse(date);
  return weekDayFormat.format(dateTime);
}

