import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/login_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    SplashScreen.id : (context) => SplashScreen(),
    LoginScreen.id : (context) => LoginScreen(),
    HomeScreen.id : (context) => HomeScreen(),
  };
}
