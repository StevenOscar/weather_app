import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_color.dart';
import 'package:weather_app/constants/assets_fonts.dart';
import 'package:weather_app/screens/login_screen.dart';
import 'package:weather_app/styles/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  static const id = "/";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> changePage() {
    // Ke Halaman Login setelah 2 detik
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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.backgroundGradient,
            boxShadow: [
              BoxShadow(
                blurRadius: 150,
                color: Color.fromARGB(179, 59, 38, 123),
                offset: Offset(-40, 60),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_outlined, size: 200, color: AppColors.whitePrimary),
              SizedBox(height: 20),
              Text(
                "Weather App",
                style: AppTextStyles.boldLargeTItle(fontFamily: AssetsFonts.sfProDisplay),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
