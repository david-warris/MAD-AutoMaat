import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://localhost:8080';

  Future<http.Response> get(String endpoint, {String? token}) async {
    return http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: token != null ? {'Authorization': 'Bearer $token'} : {},
    );
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body, {String? token}) async {
    return http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }
}