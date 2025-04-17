

import 'package:flutter/material.dart';
import '../models/city_weather_model.dart'; // Import the model

class CityDetailPage extends StatelessWidget {
  final CityWeather cityWeather;
  final bool isDarkMode; 

  // Constructor-taking the city weather data and dark mode state
  CityDetailPage({required this.cityWeather, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text('${cityWeather.city} Weather'),
        backgroundColor: isDarkMode
            ? Colors.grey.shade800
            : const Color.fromARGB(255, 71, 144, 255),
      ),
      body: Container(
        height: screenSize.height,  
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey.shade900, Colors.black],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade500, Colors.blue.shade900],
                ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: isLandscape ? 10 : 20),
                    Text(
                      '${cityWeather.city}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isLandscape ? 24 : 32, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Current Temperature: ${cityWeather.temperature}°C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isLandscape ? 18 : 20, 
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Condition: ${cityWeather.condition}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isLandscape ? 18 : 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Icon(
                        cityWeather.icon,
                        color: Colors.white,
                        size: isLandscape ? screenSize.width * 0.25 : 100, 
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Wind Speed: 15 km/h', 
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isLandscape ? 14 : 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Humidity: 78%',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isLandscape ? 14 : 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Pressure: 1013 hPa',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isLandscape ? 14 : 16,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            '© 2024 WeatherApp, Inc',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: isLandscape ? 14 : 16,
                            ),
                          ),
                        ],
                      ),
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
