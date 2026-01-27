import 'package:automaat_mad/services/api_service.dart';
import 'package:automaat_mad/services/auth_service.dart';
import 'package:automaat_mad/services/rental_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: false);
    final AuthService authService = Provider.of<AuthService>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profiel')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const CircleAvatar(radius: 50),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Change password logic
                    },
                    child: const Text('Wachtwoord wijzigen'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mijn verhuuringen',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FutureBuilder(
              future: RentalService(api: api).fetchRentalsForCustomer(authService.user!.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final rentals = snapshot.data ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rentals.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(rentals[index].startDate.toString()),
                      subtitle: Text(rentals[index].endDate.toString()),
                      trailing: const Icon(Icons.arrow_forward),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
