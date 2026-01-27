import 'package:automaat_mad/services/api_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final firstnameController = TextEditingController();
    final lastnameController = TextEditingController();
    final emailController = TextEditingController();
    final languageController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordRecheckController = TextEditingController();
    final apiService = ApiService();

    return Scaffold(
      backgroundColor: const Color(0xFF1E5A96),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                'AUTOMAAT',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 40),
              _buildTextField(
                controller: usernameController,
                hintText: 'USERNAME',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: firstnameController,
                hintText: 'FIRST NAME',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: lastnameController,
                hintText: 'LAST NAME',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: emailController,
                hintText: 'EMAIL',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: languageController,
                hintText: 'LANGUAGE',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: passwordController,
                hintText: 'PASSWORD',
                obscureText: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: passwordRecheckController,
                hintText: 'RE-ENTER PASSWORD',
                obscureText: true,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    try {
                      if (passwordController.text !=
                          passwordRecheckController.text) {
                        throw Exception('Passwords do not match');
                      } else if (!emailController.text.contains('@') ||
                          !emailController.text.contains('.')) {
                        throw Exception('Invalid email address');
                      } else {
                        await apiService.post('/api/AM/register', {
                          'login': usernameController.text,
                          'firstName': firstnameController.text,
                          'lastName': lastnameController.text,
                          'email': emailController.text,
                          'langKey': languageController.text,
                          'password': passwordController.text,
                        }, auth: false);
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: const Color(0xFFFAD94D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
