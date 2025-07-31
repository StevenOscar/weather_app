import 'dart:convert';

import 'package:weather_app/constants/endpoint.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/services/global_http_client.dart';

class WeahterServices {
  Future<CurrentWeatherModel> fetchCurrentWeather({
    required double lat,
    required double long,
  }) async {
    try {
      final response = await GlobalHttpClient.get(
        url: Uri.parse("${Endpoint.weatherApi}/weather"),
        queryParams: {"lat": lat, "lon": long},
      );
      if (response.statusCode == 200) {
        return currentWeatherModelFromJson(response.body);
      } else {
        String errorMessage;
        try {
          final decoded = json.decode(response.body);
          errorMessage = decoded["message"] ?? "Unknown error";
        } catch (_) {
          errorMessage = "Unexpected error: ${response.body}";
        }
        throw Exception('Error ${response.statusCode}: $errorMessage');
      }
    } catch (e) {
      rethrow;
    }
  }
}
