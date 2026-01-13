import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  static const String baseUrl = 'http://localhost:8080';

  String? _token;
  void setToken(String token) {
    _token = token;
    if (kDebugMode) {
      print('Token set: $_token');
    }
  }
  void clearToken() {
    _token = null;
    if (kDebugMode) {
      print('Token cleared');
    }
  }

  Map<String, String> _headers({bool auth = true}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (auth && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }

    return headers;
  }
  
  http.Response _handleResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return response;

    case 400:
      throw Exception('Bad request');

    case 401:
      clearToken(); // auto logout
      throw Exception('Niet ingelogd');

    case 403:
      throw Exception('Geen rechten');

    case 404:
      throw Exception('Niet gevonden');

    case 500:
      throw Exception('Server error');

    default:
      throw Exception(
        'Onbekende fout: ${response.statusCode}',
      );
  }
  }
  Future<http.Response> post(
  String endpoint,
  Map<String, dynamic> body, {
  bool auth = true,
  }) async {
  final response = await http.post(
    Uri.parse('$baseUrl$endpoint'),
    headers: _headers(auth: auth),
    body: jsonEncode(body),
  );

  return _handleResponse(response);
  }

  Future<http.Response> get(
  String endpoint, {
  bool auth = true,
  }) async {
  final response = await http.get(
    Uri.parse('$baseUrl$endpoint'),
    headers: _headers(auth: auth),
  );

  return _handleResponse(response);
  }
}