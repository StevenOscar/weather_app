import 'package:http/http.dart' as http;

class GlobalHttpClient {
  static Future<http.Response> get({required Uri url, Map<String, dynamic>? queryParams}) {
    if (queryParams != null) {
      url.replace(queryParameters: queryParams);
    }
    return http.get(url);
  }
}
