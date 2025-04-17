import 'package:flutter/material.dart';

class CityWeather {
  final String city;
  final int temperature;
  final String condition;
  final IconData icon;

  CityWeather({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.icon,
  });

  get humidity => null;

  get windSpeed => null;
}
