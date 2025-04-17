



import 'package:flutter/material.dart';
import '../models/city_weather_model.dart';
import 'city_detail_page.dart'; 

class SearchPage extends StatelessWidget {
  final bool isDarkMode;
  final List<CityWeather> cities = [
    CityWeather(city: 'London', temperature: 14, condition: 'overcast clouds', icon: Icons.cloud),
    CityWeather(city: 'Paris', temperature: 18, condition: 'overcast clouds', icon: Icons.cloud),
    CityWeather(city: 'New York', temperature: 16, condition: 'clear sky', icon: Icons.wb_sunny),
    CityWeather(city: 'Sydney', temperature: 13, condition: 'moderate rain', icon: Icons.grain),
    CityWeather(city: 'Bangkok', temperature: 23, condition: 'overcast clouds', icon: Icons.cloud),
    CityWeather(city: 'Dubai', temperature: 31, condition: 'clear sky', icon: Icons.wb_sunny),
  ];

  SearchPage({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    
    final crossAxisCount = isLandscape ? 3 : 2;  

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isLandscape ? 20 : 50),
                Text(
                  'Pick Location',
                  style: TextStyle(fontSize: 27, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  'Find the area or city that you want to know the detailed weather info at this time',
                  style: TextStyle(fontSize: 16, color: Colors.white60),
                ),
                SizedBox(height: 20),
                SearchBar(isDarkMode: isDarkMode),
                SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true, 
                  physics: NeverScrollableScrollPhysics(), 
                  itemCount: cities.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: isLandscape ? 1.1 : 0.8, 
                  ),
                  itemBuilder: (context, index) {
                    final cityWeather = cities[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityDetailPage(cityWeather: cityWeather, isDarkMode: isDarkMode),
                          ),
                        );
                      },
                      child: CityWeatherCard(
                          cityWeather: cityWeather, isLandscape: isLandscape, isDarkMode: isDarkMode),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final bool isDarkMode;

  SearchBar({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade800 : Colors.blue.shade700,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white60),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Icon(Icons.location_on, color: Colors.white),
        ],
      ),
    );
  }
}

class CityWeatherCard extends StatelessWidget {
  final CityWeather cityWeather;
  final bool isLandscape;
  final bool isDarkMode;

  CityWeatherCard({required this.cityWeather, required this.isLandscape, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: cityWeather.condition.contains('clear')
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orangeAccent, Colors.blueAccent],
              )
            : cityWeather.condition.contains('rain')
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey.shade800, Colors.blueGrey.shade900],
                  )
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDarkMode
                        ? [Colors.grey.shade700, Colors.grey.shade900]
                        : [Colors.blue.shade700, Colors.blue.shade900],
                  ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${cityWeather.temperature}°',
              style: TextStyle(color: Colors.white, fontSize: screenWidth > 600 ? 24 : 32),
            ),
            SizedBox(height: 5),
            Icon(cityWeather.icon, color: Colors.white, size: screenWidth > 600 ? 50 : 40),
            SizedBox(height: 5),
            Text(
              cityWeather.condition,
              style: TextStyle(color: Colors.white, fontSize: isLandscape ? 12 : 14),
            ),
            SizedBox(height: 7),
            Text(
              cityWeather.city,
              style: TextStyle(color: Colors.white, fontSize: isLandscape ? 16 : 20),
            ),
          ],
        ),
      ),
    );
  }
}
