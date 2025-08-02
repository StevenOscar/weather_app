import 'package:http/http.dart' as http;
import 'package:weather_app/env/env.dart';

class GlobalHttpClient {
  static Future<http.Response> get({required Uri url, Map<String, dynamic>? queryParams}) {
    if (queryParams != null) {
      queryParams["appid"] = Env.apiKey;
      final stringParams = queryParams.map((k, v) => MapEntry(k, v.toString()));
      url = url.replace(queryParameters: stringParams);
    }
    return http.get(url);
  }
}
