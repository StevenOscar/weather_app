import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/constants/app_routes.dart';
import 'package:weather_app/screens/splash_screen.dart';

void main() {
  // Mengubah icon di status bar sehingga menjadi putih
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
      routes: AppRoutes.routes,
      initialRoute: SplashScreen.id,
    );
  }
}
