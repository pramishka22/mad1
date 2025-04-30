


import 'package:flutter/material.dart';
import 'package:weatherapp1/pages/LoginPage.dart';
import '../models/settings_model.dart';
import 'about_us_page.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode; 
  final Function(bool) onDarkModeToggle; 

  SettingsPage({required this.isDarkMode, required this.onDarkModeToggle});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsModel settings = SettingsModel(
    isDarkTheme: false,
    notificationsEnabled: true,
    temperatureUnit: 'Celsius',
  );

  String _username = "Kavinkumar Naidu"; 

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: const Color.fromARGB(255, 71, 144, 255),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate back to the login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight, 
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: widget.isDarkMode
                    ? [Colors.grey.shade900, Colors.black]
                    : [Colors.blue.shade500, Colors.blue.shade900],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
               ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profilepic.jpeg'),
                  ),
                  title: Text(
                    _username,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  subtitle: Text(
                    'View and edit your profile',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Divider(color: Colors.white60),

                // Notification- Toggle
                SwitchListTile(
                  activeColor: Colors.white,
                  title: Text(
                    'Enable Notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: settings.notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      settings.notificationsEnabled = value;
                    });
                  },
                ),
                Divider(color: Colors.white60),

                // Temperature Unit -Selection
                Text(
                  'Temperature Unit',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                ListTile(
                  title: const Text('Celsius', style: TextStyle(color: Colors.white)),
                  leading: Radio<String>(
                    value: 'Celsius',
                    groupValue: settings.temperatureUnit,
                    onChanged: (String? value) {
                      setState(() {
                        settings.temperatureUnit = value!;
                      });
                    },
                    activeColor: Colors.white,
                  ),
                ),
                ListTile(
                  title: const Text('Fahrenheit', style: TextStyle(color: Colors.white)),
                  leading: Radio<String>(
                    value: 'Fahrenheit',
                    groupValue: settings.temperatureUnit,
                    onChanged: (String? value) {
                      setState(() {
                        settings.temperatureUnit = value!;
                      });
                    },
                    activeColor: Colors.white,
                  ),
                ),
                Divider(color: Colors.white60),

                // "About Us" Button
                ListTile(
                  title: Text('About Us', style: TextStyle(color: Colors.white, fontSize: 18)),
                  leading: Icon(Icons.info, color: Colors.white),
                  onTap: () {
                    // Navigate to the About Us Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUsPage(isDarkMode: widget.isDarkMode), // Pass isDarkMode
                      ),
                    );
                  },
                ),
                Divider(color: Colors.white60),

                if (orientation == Orientation.landscape) SizedBox(height: 114),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
