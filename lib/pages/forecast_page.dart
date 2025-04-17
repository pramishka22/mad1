


import 'package:flutter/material.dart';
import '../models/forecast_model.dart';

class ForecastPage extends StatelessWidget {
  final bool isDarkMode;

  final List<Forecast> todayForecast = [
    Forecast(time: '16:30', temperature: 12, icon: Icons.wb_sunny),
    Forecast(time: '19:30', temperature: 13, icon: Icons.wb_sunny),
  ];

  final List<Forecast> nextForecast = [
    Forecast(day: 'Saturday', temperature: 24, icon: Icons.wb_sunny, date: '2024-06-01'),
    Forecast(day: 'Sunday', temperature: 25, icon: Icons.cloud, date: '2024-06-02'),
    Forecast(day: 'Monday', temperature: 21, icon: Icons.cloud, date: '2024-06-03'),
  ];

  ForecastPage({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [Colors.grey.shade900, Colors.black]
                : [Colors.blue.shade500, Colors.blue.shade900],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Forecast Report',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(fontSize: 20, color: Colors.white60),
                ),
                Text(
                  'June 1, 2024',
                  style: TextStyle(fontSize: 14, color: Colors.white60),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: todayForecast.map(
                          (forecast) => TodayForecastCard(forecast: forecast, isDarkMode: isDarkMode),
                        ).toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Next Forecast',
                      style: TextStyle(fontSize: 20, color: Colors.white60),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // Use parent scroll
                      itemCount: nextForecast.length,
                      itemBuilder: (context, index) {
                        return NextForecastCard(forecast: nextForecast[index], isDarkMode: isDarkMode);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodayForecastCard extends StatelessWidget {
  final Forecast forecast;
  final bool isDarkMode;

  TodayForecastCard({required this.forecast, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10),
      width: 120, 
      decoration: BoxDecoration(
        gradient: forecast.icon == Icons.wb_sunny
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orangeAccent, Colors.blueAccent],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode
                    ? [Colors.grey.shade800, Colors.black54]
                    : [Colors.grey.shade800, Colors.blueGrey.shade900],
              ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            forecast.time!,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 5),
          Icon(forecast.icon, color: Colors.white, size: 32),
          SizedBox(height: 5),
          Text(
            '${forecast.temperature}°',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class NextForecastCard extends StatelessWidget {
  final Forecast forecast;
  final bool isDarkMode;

  NextForecastCard({required this.forecast, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: forecast.icon == Icons.wb_sunny
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orangeAccent, Colors.blueAccent],
              )
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode
                    ? [Colors.grey.shade800, Colors.black54]
                    : [Colors.grey.shade800, Colors.blueGrey.shade900],
              ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                forecast.day!,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                forecast.date!,
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${forecast.temperature}°C',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(width: 10),
              Icon(forecast.icon, color: Colors.white, size: 32),
            ],
          ),
        ],
      ),
    );
  }
}
