

import 'package:flutter/material.dart';
import 'models/weather_model.dart';
import 'pages/forecast_page.dart';
import 'pages/search_page.dart';
import 'pages/settings_page.dart';
import 'pages/weather_page.dart';

class WeatherHome extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeToggle;

  WeatherHome({required this.isDarkMode, required this.onDarkModeToggle});

  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  int _currentIndex = 0;

  final WeatherModel weatherData = WeatherModel(
    cityName: 'Union Place',
    description: 'Thunderstorm',
    temperature: 31.1,
    windSpeed: 9.7,
    humidity: 90,
    forecast: [
      Forecast(time: '16:30', temperature: 31.1, icon: 'cloud'),
      Forecast(time: '18:30', temperature: 30.5, icon: 'cloud'),
      Forecast(time: '20:30', temperature: 29.0, icon: 'cloud'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      WeatherPage(weatherData: weatherData, isDarkMode: widget.isDarkMode),
      SearchPage(isDarkMode: widget.isDarkMode),
      ForecastPage(isDarkMode: widget.isDarkMode),
      SettingsPage(
        isDarkMode: widget.isDarkMode,
        onDarkModeToggle: widget.onDarkModeToggle,
      ),
    ];

    final List<LinearGradient> _backgroundGradients = [
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color.fromARGB(255, 8, 62, 178), Color.fromARGB(255, 118, 144, 227)],
      ),
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.indigo.shade700, Colors.black],
      ),
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.grey.shade800, Colors.blueGrey.shade900],
      ),
      LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blue.shade300, Colors.blue.shade900],
      ),
    ];

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: _backgroundGradients[_currentIndex],
        ),
        child: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _pages[_currentIndex],
                transitionBuilder: (Widget child, Animation<double> animation) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(position: offsetAnimation, child: child);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Color.fromARGB(255, 1, 40, 100)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildNavItem(Icons.home, 'Home', currentIndex == 0),
            _buildNavItem(Icons.search, 'Search', currentIndex == 1),
            _buildNavItem(Icons.cloud, 'Forecast', currentIndex == 2),
            _buildNavItem(Icons.settings, 'Settings', currentIndex == 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, bool isActive) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Icon(icon, size: isActive ? 30 : 26),
          if (isActive)
            Container(
              width: 6,
              height: 6,
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
        ],
      ),
      label: label,
    );
  }
}
