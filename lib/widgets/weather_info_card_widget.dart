import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_color.dart';
import 'package:weather_app/constants/assets_fonts.dart';
import 'package:weather_app/styles/app_text_styles.dart';

class WeatherInfoCardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  const WeatherInfoCardWidget({super.key, required this.title, required this.icon, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.weatherColorSolid3),
          color: AppColors.weatherContainer,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon,color: AppColors.darkSecondary),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.boldHeadline(
                      fontFamily: AssetsFonts.sfProText,
                      color: AppColors.darkSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    content,
                    style: AppTextStyles.boldTitle2(fontFamily: AssetsFonts.sfProText),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
