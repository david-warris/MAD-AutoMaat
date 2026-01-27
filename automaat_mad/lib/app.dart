import 'package:automaat_mad/screens/damage_report_screen.dart';
import 'package:automaat_mad/screens/rental_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

class AutoMaatApp extends StatelessWidget {
  const AutoMaatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoMaat',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1E5A96), // Blue color
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E5A96),
          elevation: 0,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/rental': (_) => const RentalScreen(),
        '/damage_report': (_) => const DamageReportScreen(),
      },
    );
  }
}