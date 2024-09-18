import 'package:flutter/material.dart';
import 'package:myfinance/screens/home_screen.dart';
import 'package:myfinance/screens/login_screen.dart';
import 'package:myfinance/screens/register_screen.dart';
import 'package:myfinance/splash_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/splash': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/register': (context) => RegisterScreen(),
      '/home': (context) => HomePage(),
    };
  }
}
