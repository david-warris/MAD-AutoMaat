import 'package:automaat_mad/app.dart';
import 'package:automaat_mad/services/api_service.dart';
import 'package:automaat_mad/services/auth_service.dart';
import 'package:automaat_mad/services/rental_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final apiService = ApiService();
  runApp(
    MultiProvider(
      providers: [
    ChangeNotifierProvider(create: (_) => AuthService(api: apiService)), // beheert login/token
    Provider(create: (_) => apiService), // alle API calls via deze instance
  ],
      child: const AutoMaatApp(),
    ),
  );
}

