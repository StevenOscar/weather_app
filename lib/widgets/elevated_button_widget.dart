import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_color.dart';
import 'package:weather_app/constants/assets_fonts.dart';
import 'package:weather_app/styles/app_text_styles.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final double? radius;
  final double? elevation;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? disabledBackgroundColor;

  const ElevatedButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.radius,
    this.verticalPadding,
    this.elevation,
    this.horizontalPadding, this.disabledBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation ?? 0,
        disabledBackgroundColor:
            disabledBackgroundColor ?? AppColors.blackPrimary.withValues(alpha: 0.125),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 25)),
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? 12,
          horizontal: horizontalPadding ?? 0,
        ),
      ),
      child: Text(text, style: AppTextStyles.boldCallout(fontFamily: AssetsFonts.sfProText)),
    );
  }
}
