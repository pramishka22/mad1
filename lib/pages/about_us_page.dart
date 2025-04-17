





import 'package:flutter/material.dart';
import 'loginpage.dart'; 

class AboutUsPage extends StatelessWidget {
  final bool isDarkMode; 

  AboutUsPage({required this.isDarkMode}); 

  @override
  Widget build(BuildContext context) {
    // Checking the orientation 
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: const Color.fromARGB(255, 71, 144, 255),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate - login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Navigate-LoginPage
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height // Full screen - portrait
              : null, // Allowing scroll- landscape if overflow
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [Colors.grey.shade900, Colors.black]
                  : [Colors.blue.shade500, Colors.blue.shade900],
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Who We Are',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We are a dedicated team committed to providing accurate and real-time weather data to users all over the world. Our mission is to make weather information accessible and easy to understand for everyone.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Our Vision',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Our goal is to become the leading platform for reliable and comprehensive weather updates. We aim to innovate in the weather space by integrating cutting-edge technology and user-friendly design.',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              //  orientation- adjusting the space
              orientation == Orientation.portrait
                  ? Spacer() 
                  : SizedBox(height: 20), 
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud, color: Colors.white, size: 60),
                    SizedBox(height: 10),
                    Text(
                      'Your Weather Companion',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), 
            ],
          ),
        ),
      ),
    );
  }
 }