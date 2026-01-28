import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:8080';
  String? token;

  void setToken(String? token) {
    this.token = token; 
  }

  Map<String, String> headers({bool auth = true}) {
    final headers = {'Content-Type': 'application/json'};
    if (auth && token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  
  http.Response handleResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return response;

    case 400:
      throw Exception('Bad request');

    case 401:
      debugPrint('Unauthorized: ${response.body}');
      debugPrint(token);
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
    headers: headers(auth: auth),
    body: jsonEncode(body),
  );

  return handleResponse(response);
  }

  Future<http.Response> get(
  String endpoint, {
  Map<String, dynamic>? queryParameters,
  bool auth = true,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(
    queryParameters: queryParameters?.map(
      (key, value) => MapEntry(key, value.toString()),
    ),
  );
  final response = await http.get(
    uri,
    headers: headers(auth: auth),
  );

  return handleResponse(response);
  }

  Future<http.Response> put(
  String endpoint,
  Map<String, dynamic> body, {
  bool auth = true,
  }) async {
  final response = await http.put(
    Uri.parse('$baseUrl$endpoint'),
    headers: headers(auth: auth),
    body: jsonEncode(body),
  );

  return handleResponse(response);
  }

  Future<http.Response> patch(
  String endpoint,
  Map<String, dynamic> body, {
  bool auth = true,
  }) async {
  final response = await http.patch(
    Uri.parse('$baseUrl$endpoint'),
    headers: headers(auth: auth),
    body: jsonEncode(body),
  );

  return handleResponse(response);

  }
  Future<http.Response> delete(
  String endpoint, {
  bool auth = true,
  }) async {
  final response = await http.delete(
    Uri.parse('$baseUrl$endpoint'),
    headers: headers(auth: auth),
  );

  return handleResponse(response);
  } 
}