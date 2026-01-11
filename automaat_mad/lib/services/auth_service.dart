import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AuthService {
  final ApiService api = ApiService();

  Future<String> login(String username, String password) async {
    final response = await api.post('/api/authenticate', {
      'username': username,
      'password': password,
      'rememberMe': true,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['id_token'];
    } else {
      throw Exception('Login mislukt');
    }
  }
}