import 'package:automaat_mad/models/rental.dart';
import 'package:automaat_mad/services/api_service.dart';
import 'package:automaat_mad/services/location_service.dart';
import 'package:automaat_mad/services/rental_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rental = ModalRoute.of(context)!.settings.arguments as Rental;
    return Scaffold(
      appBar: AppBar(title: Text('${rental.car.brand} ${rental.car.model}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TODO: Auto afbeelding
            const SizedBox(height: 12),
            Text('Locatie: ${rental.car.latitude}, ${rental.car.longitude}'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                try {
                  final position = await getCurrentLocation();
                  final api = Provider.of<ApiService>(context, listen: false);
                  await RentalService(api: api).updateRental(rental.id, {
                    'id': rental.id,
                    'latitude': position.latitude,
                    'longitude': position.longitude,
                    'state': 'RETURNED',
                    'toDate': DateTime.now().toIso8601String(),
                  });
                  Navigator.pushNamed(context, '/home');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Fout bij het stoppen met huren van auto: $e',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Stop met huren'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/damage_report', arguments: rental);
              },
              child: const Text('Schade melden'),
            ),
          ],
        ),
      ),
    );
  }
}
