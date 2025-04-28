
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onDarkModeToggle;

  SignUpPage({required this.isDarkMode, required this.onDarkModeToggle});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _temperatureUnit = 'Celsius'; // default is celsius
  bool _agreedToTerms = false; // Default state for terms checkbox

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: widget.isDarkMode
            ? Color.fromARGB(255, 156, 189, 241)
            : Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: widget.isDarkMode
                    ? [Colors.grey.shade900, Colors.black]
                    : [Colors.blue.shade600, Colors.blue.shade900],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHeader(),
                SizedBox(height: 30),
                _buildTextField(_usernameController, 'Username', icon: Icons.person),
                SizedBox(height: 20),
                _buildTextField(_emailController, 'Email', icon: Icons.email),
                SizedBox(height: 20),
                _buildTextField(_passwordController, 'Password', icon: Icons.lock, obscureText: true),
                SizedBox(height: 20),
                _buildTextField(_confirmPasswordController, 'Confirm Password', icon: Icons.lock, obscureText: true),
                SizedBox(height: 20),
                _buildTemperatureUnitSelector(),
                SizedBox(height: 20),
                _buildAgreeToTermsCheckbox(),
                SizedBox(height: 30),
                _buildSignUpButton(),
                if (orientation == Orientation.landscape) SizedBox(height: 114),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          Icons.person_add_outlined,
          size: 80,
          color: Colors.white,
        ),
        SizedBox(height: 10),
        Text(
          'Create a New Account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool obscureText = false, IconData? icon, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
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

  Widget _buildTemperatureUnitSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Temperature Unit:',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text('Celsius', style: TextStyle(color: Colors.white)),
                value: 'Celsius',
                groupValue: _temperatureUnit,
                onChanged: (value) {
                  setState(() {
                    _temperatureUnit = value!;
                  });
                },
                activeColor: Colors.white,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text('Fahrenheit', style: TextStyle(color: Colors.white)),
                value: 'Fahrenheit',
                groupValue: _temperatureUnit,
                onChanged: (value) {
                  setState(() {
                    _temperatureUnit = value!;
                  });
                },
                activeColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAgreeToTermsCheckbox() {
    return CheckboxListTile(
      value: _agreedToTerms,
      onChanged: (value) {
        setState(() {
          _agreedToTerms = value!;
        });
      },
      title: Text(
        'I agree to the Terms and Conditions',
        style: TextStyle(color: Colors.white),
      ),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _signUp,
      child: Text(
        'Sign Up',
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

  void _signUp() {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    List<String> errors = [];

    if (username.isEmpty) {
      errors.add('Username is required.');
    }

    if (email.isEmpty) {
      errors.add('Email is required.');
    } else if (!email.contains('@')) {
      errors.add('Please enter a valid email address.');
    }

    if (password.isEmpty) {
      errors.add('Password is required.');
    } else if (password.length < 8) {
      errors.add('Password must be at least 8 characters long.');
    }

    if (confirmPassword.isEmpty) {
      errors.add('Confirm Password is required.');
    } else if (password != confirmPassword) {
      errors.add('Passwords do not match.');
    }

    if (!_agreedToTerms) {
      errors.add('You must agree to the Terms and Conditions.');
    }

    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errors.join('\n')),
          duration: Duration(seconds: 4),
        ),
      );
      return;
    }

    Navigator.pop(context);
  }
}
