import 'package:flutter/material.dart';
import 'package:weather_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const id = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> changePage() {
    return Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(context, LoginScreen.id);
    });
  }

  @override
  void initState() {
    super.initState();
    changePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Icon(Icons.cloud_outlined), SizedBox(height: 8), Text("Weather App")],
        ),
      ),
    );
  }
}
