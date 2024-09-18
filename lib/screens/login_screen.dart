import 'package:flutter/material.dart';
import 'package:myfinance/services/auth_service.dart';
import 'package:myfinance/utils/constants.dart'; // Import constants for color themes
import 'package:myfinance/utils/helpers.dart'; // Assuming helpers for showing error

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var isDarkMode = themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: primaryColor, // Gold-like color
        foregroundColor: headerTextColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryGradientColor,
              secondaryGradientColor
            ], // Gradient from dark gray to black
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () async {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        if (await _authService.login(email, password)) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          showError(context, 'Invalid login credentials');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: primaryColor, // Gold for the button
                        foregroundColor: textColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Login',
                              style: TextStyle(color: textColorButton)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (await _authService.signInWithGoogle()) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          showError(context, 'Failed to sign up with Google');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.red,
                        foregroundColor: textColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.plus_one_sharp, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Sign In with Google',
                              style: TextStyle(color: textColorButton)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (await _authService.loginWithFacebook()) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          showError(context, 'Failed to log in with Facebook');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.blue[800],
                        foregroundColor: textColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.facebook, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Sign In with Facebook',
                              style: TextStyle(color: textColorButton)),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Don\'t have an account? Register here',
                        style:
                            TextStyle(color: textColor), // Gold color for text
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
