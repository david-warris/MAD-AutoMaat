import 'dart:convert';
import 'package:automaat_mad/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_service.dart';

class AuthService with ChangeNotifier {
  String? _token;
  User? _user;

  final _storage = FlutterSecureStorage();
  final ApiService api ;

  AuthService({required this.api});

  String? get token => _token;
  User? get user => _user;
  bool get isLoggedIn => _token != null;

  Future<void> login(String username, String password) async {
    final response = await api.post('/api/authenticate', {
      'username': username,
      'password': password,
      'rememberMe': true,
    }, auth: false);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['id_token'];
      debugPrint('Token: $_token');
      api.setToken(_token);

      await _storage.write(key: 'authToken', value: _token!);
      await fetchUser();
      notifyListeners();
    } else {
      throw Exception('Login mislukt');
    }
  }

  Future<void> fetchUser() async {
    final response = await api.get('/api/AM/account');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _user = User(id: data['id'], username: data['login']);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = null;
    _token = null;
    api.setToken(null);
    await _storage.delete(key: 'authToken');
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    final storedToken = await _storage.read(key: 'authToken');
    if (storedToken != null) {
      _token = storedToken;
      api.setToken(_token); 
      await fetchUser();
    }
  }
}
