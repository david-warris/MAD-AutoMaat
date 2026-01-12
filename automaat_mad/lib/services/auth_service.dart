import 'dart:convert';
import 'api_service.dart';

class AuthService {
  final ApiService api = ApiService();

  Future<String> login(String username, String password) async {
    final response = await api.post('/api/authenticate', {
      'username': username,
      'password': password,
      'rememberMe': true,
    },
    auth: false,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['id_token'];
      api.setToken(token);
      return token;
    } else {
      throw Exception('Login mislukt');
    }
  }
}