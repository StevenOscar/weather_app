import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_color.dart';

class AppTextStyles {
  static TextStyle regularCaption2({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w400,
      height: 13 / 11,
      letterSpacing: 0.07,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularCaption1({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
      letterSpacing: 0,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularFootnote({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 18 / 13,
      letterSpacing: -0.08,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularSubHeadline({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 20 / 15,
      letterSpacing: -0.24,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularCallout({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 21 / 16,
      letterSpacing: -0.32,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularBody({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 22 / 17,
      letterSpacing: -0.41,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularHeadline({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 22 / 17,
      letterSpacing: -0.41,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularTitle3({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      height: 24 / 20,
      letterSpacing: 0.38,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularTitle2({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w400,
      height: 28 / 22,
      letterSpacing: 0.35,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularTitle1({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w400,
      height: 34 / 28,
      letterSpacing: 0.36,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle regularLargeTItle({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 34,
      fontWeight: FontWeight.w400,
      height: 41 / 34,
      letterSpacing: 0.37,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldCaption2({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      height: 13 / 11,
      letterSpacing: 0.07,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldCaption1({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12,
      letterSpacing: 0,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldFootnote({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      height: 18 / 13,
      letterSpacing: -0.08,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldSubHeadline({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      height: 20 / 15,
      letterSpacing: -0.24,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldCallout({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 21 / 16,
      letterSpacing: -0.32,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldBody({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 22 / 17,
      letterSpacing: -0.41,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle? boldHeadline({
    required String fontFamily,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 22 / 17,
      letterSpacing: -0.41,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldTitle3({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 24 / 20,
      letterSpacing: 0.38,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldTitle2({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      height: 28 / 22,
      letterSpacing: 0.35,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldTitle1({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 34 / 28,
      letterSpacing: 0.36,
      color: color ?? AppColors.whitePrimary,
    );
  }

  static TextStyle boldLargeTItle({required String fontFamily, Color? color}) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: 34,
      fontWeight: FontWeight.w700,
      height: 41 / 34,
      letterSpacing: 0.37,
      color: color ?? AppColors.whitePrimary,
    );
  }
}
