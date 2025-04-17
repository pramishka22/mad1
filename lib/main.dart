
import 'package:flutter/material.dart';
import 'pages/LoginPage.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: LoginPage(), 
      debugShowCheckedModeBanner: false,
    );
  }
}
