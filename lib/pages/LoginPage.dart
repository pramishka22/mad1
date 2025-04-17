


import 'package:flutter/material.dart';
import 'package:weatherapp1/weather_home.dart'; 
import 'signuppage.dart'; 

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoginFailed = false;
  bool _isDarkMode = false;

 
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize- animation 
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _isDarkMode
                ? [Colors.grey.shade900, Colors.black]
                : [Colors.blue.shade600, Colors.blue.shade900],
          ),
        ),
        padding: EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isContentScrollable = constraints.maxHeight < 600;

            return SingleChildScrollView(
              physics: isContentScrollable ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: isLandscape ? screenSize.height : screenSize.height,
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      SizedBox(height: 30),
                      _buildTextField(_usernameController, 'Username', icon: Icons.person),
                      SizedBox(height: 20),
                      _buildTextField(_passwordController, 'Password', icon: Icons.lock, obscureText: true),
                      SizedBox(height: 20),
                      if (_isLoginFailed)
                        Text(
                          'Login failed, please try again.',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(height: 30),
                      _buildLoginButton(),
                      SizedBox(height: 20),
                      _buildSignUpButton(),  // SignUp button
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: 20.0,
          left: MediaQuery.of(context).size.height > MediaQuery.of(context).size.width ? 20.0 : 0.0, // Left in portrait mode
          right: MediaQuery.of(context).size.height > MediaQuery.of(context).size.width ? 0.0 : 20.0, // Right in landscape mode
        ),
        child: Align(
          alignment: MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
              ? Alignment.bottomLeft // Align to the left in portrait mode
              : Alignment.bottomRight, // Align to the right in landscape mode
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
            backgroundColor: _isDarkMode ? Colors.grey : Colors.blue,
            child: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      
      children: [
       
        Image.asset('assets/animation.gif', 
          height: 100, 
          width: 1000,
        ),
        SizedBox(height: 10),
        Text(
          'Welcome to Weather App',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false, IconData? icon}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.white60) : null,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white60),
        filled: true,
        fillColor: Colors.blue.shade700.withOpacity(0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      child: Text(
        'Login',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 22, 69, 122),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadowColor: Color.fromARGB(115, 44, 40, 40),
        elevation: 5,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpPage(
              isDarkMode: _isDarkMode, // sending-  the current dark mode status
              onDarkModeToggle: (value) {
                setState(() {
                  _isDarkMode = value; 
                });
              },
            ),
          ),
        );
      },
      child: Text(
        'Don\'t have an account? Sign Up',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _login() {
    if (_usernameController.text == 'u' && _passwordController.text == 'p') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherHome(
            isDarkMode: _isDarkMode, 
            onDarkModeToggle: (value) {
              setState(() {
                _isDarkMode = value; 
              });
            },
          ),
        ),
      );
    } else {
      setState(() {
        _isLoginFailed = true; //  login -failed message
      });
    }
  }
}
