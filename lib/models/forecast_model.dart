import 'package:flutter/material.dart';

class Forecast {
  final String? time;
  final String? day;
  final int temperature;
  final IconData icon;
  final String? date;

  Forecast({
    this.time,
    this.day,
    required this.temperature,
    required this.icon,
    this.date,
  });
}
