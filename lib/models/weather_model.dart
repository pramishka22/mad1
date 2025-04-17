
class WeatherModel {
  final String cityName;
  final String description;
  final double temperature;
  final double windSpeed;
  final int humidity;
  final List<Forecast> forecast;

  WeatherModel({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.forecast,
  });
}

class Forecast {
  final String time;
  final double temperature;
  final String icon;

  Forecast({
    required this.time,
    required this.temperature,
    required this.icon,
  });
}
