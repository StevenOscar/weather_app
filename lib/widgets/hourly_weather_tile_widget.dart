import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_color.dart';
import 'package:weather_app/constants/assets_fonts.dart';
import 'package:weather_app/styles/app_text_styles.dart';
import 'package:weather_app/utils/datetime_formatter.dart';

class HourlyWeatherTileWidget extends StatelessWidget {
  final DateTime time;
  final String image;
  final Color color;
  final double temperature;
  const HourlyWeatherTileWidget({
    super.key,
    required this.time,
    required this.image,
    required this.temperature,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 80,
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: color,
        border: Border.all(color: AppColors.weatherColorSolid3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DatetimeFormatter.formatDateMonth(time),
            style: AppTextStyles.boldSubHeadline(fontFamily: AssetsFonts.sfProText),
          ),
          Text(
            DatetimeFormatter.formatHour(time),
            style: AppTextStyles.boldSubHeadline(fontFamily: AssetsFonts.sfProText),
          ),
          SizedBox(height: 16),
          CachedNetworkImage(
            // Untuk mengambil icon dari API openweathermap langsung
            imageUrl: "https://openweathermap.org/img/wn/$image@2x.png",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.broken_image_outlined),
          ),
          SizedBox(height: 16),
          Text(
            "${temperature.round()}°",
            style: AppTextStyles.regularTitle3(fontFamily: AssetsFonts.sfProDisplay),
          ),
        ],
      ),
    );
  }
}
