import 'package:flutter/material.dart';

class AppColors {
  static Color whitePrimary = Color(0xFFFFFFFF);
  static Color lightSecondary = Color(0xFF3C3C43).withValues(alpha: 0.6);
  static Color lightTertiary = Color(0xFF3C3C43).withValues(alpha: 0.3);
  static Color lightQuaternary = Color(0xFF3C3C43).withValues(alpha: 0.18);
  static Color blackPrimary = Color(0xFF000000);
  static Color darkSecondary = Color(0xFFEBEBF5).withValues(alpha: 0.6);
  static Color darkTertiary = Color(0xFFEBEBF5).withValues(alpha: 0.3);
  static Color darkQuaternary = Color(0xFFEBEBF5).withValues(alpha: 0.18);
  static Color redPrimary = Colors.red;

  static Color weatherColorSolid1 = Color(0xFF48319D);
  static Color weatherColorSolid2 = Color(0xFF1F1D47);
  static Color weatherColorSolid3 = Color(0xFFC427FB);
  static Color weatherColorSolid4 = Color(0xFFE0D9FF);

  static Color weatherContainer = Color(0xFF35206a);
  static Color loginContainer = Color.fromARGB(255, 92, 59, 132);

  static RadialGradient backgroundGradient = RadialGradient(
    radius: 0.9,
    focal: Alignment.center,
    focalRadius: 0.25,
    stops: [0.1, 1.0],
    colors: [Color.fromARGB(255, 66, 46, 90), Color.fromARGB(255, 28, 27, 51)],
  );
  static LinearGradient weatherColorLinear1 = LinearGradient(
    colors: [Color(0xFF2E335A), Color(0xFF1C1B33)],
  );
  static LinearGradient weatherColorLinear2 = LinearGradient(
    colors: [Color(0xFF5936B4), Color(0xFF362A84)],
  );
  static LinearGradient weatherColorLinear3 = LinearGradient(
    colors: [Color(0xFF3658B1), Color(0xFFC159EC)],
  );
  static LinearGradient weatherColorLinear4 = LinearGradient(
    colors: [Color(0xFFAEC9FF), Color(0xFF083072)],
  );
  static RadialGradient weatherColorRadial1 = RadialGradient(
    colors: [Color(0xFFF7CBFD), Color(0xFF7758D1)],
  );
}
