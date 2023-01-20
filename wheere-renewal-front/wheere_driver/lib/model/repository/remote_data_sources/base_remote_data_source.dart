import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class BaseRemoteDataSource {
  static const _baseUrl = "";
  static const _headers = {"Accept": "application/json"};

  static Future<Map<String, dynamic>?> post(
      String path, Map<String, dynamic> body) async {
    try {
      final res = await http.post(Uri.parse(_baseUrl + path),
          headers: _headers, body: jsonEncode(body));
      switch (res.statusCode) {
        case 200:
          return json.decode(utf8.decode(res.bodyBytes));
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> put(
      String path, Map<String, dynamic> body) async {
    try {
      final res = await http.put(Uri.parse(_baseUrl + path),
          headers: _headers, body: body);
      switch (res.statusCode) {
        case 200:
          return json.decode(utf8.decode(res.bodyBytes));
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }


  String path = "";
}