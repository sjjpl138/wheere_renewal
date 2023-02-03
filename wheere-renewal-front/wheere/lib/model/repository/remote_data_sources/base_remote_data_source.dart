import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class BaseRemoteDataSource {
  static const _baseUrl = "";
  static const _headers = {"Accept": "application/json"};

  static Future<Map<String, dynamic>?> get(String path) async {
    try {
      final res = await http.get(Uri.parse(_baseUrl + path), headers: _headers);
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

  static Future<Map<String, dynamic>?> getWithParams(String path, Map<String, dynamic> queryParams) async {
    try {
      var uri = Uri.parse(path).replace(queryParameters: queryParams);
      const headers = {"Accept": "application/json"};
      final res = await http.get(uri, headers: headers);
      // var uri = Uri(
      //   scheme: "https",
      //   // host: '', //host 넣어줘야함?
      //   path: path, // ?? _baseUrl + path
      //   queryParameters: queryParams,
      // );
      // final res = await http.get(uri, headers: _headers);
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

  static Future<Map<String, dynamic>?> delete(
      String path) async {
    try {
      final res = await http.delete(Uri.parse(_baseUrl + path),
          headers: _headers);
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
