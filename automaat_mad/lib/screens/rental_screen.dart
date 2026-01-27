import 'package:automaat_mad/models/rental.dart';
import 'package:automaat_mad/services/api_service.dart';
import 'package:automaat_mad/services/location_service.dart';
import 'package:automaat_mad/services/rental_service.dart';
import 'package:automaat_mad/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RentalScreen extends StatelessWidget {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rental = ModalRoute.of(context)!.settings.arguments as Rental;
    return AppScaffold(
      title: '${rental.car.brand} ${rental.car.model}',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Car Image Placeholder
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.directions_car,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              // Car Details Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${rental.car.brand.toUpperCase()} ${rental.car.model.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Locatie: ${rental.car.latitude.toStringAsFixed(4)}, ${rental.car.longitude.toStringAsFixed(4)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Start: ${rental.startDate.toString().split('.')[0]}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    if (rental.endDate != null)
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Einde: ${rental.endDate.toString().split('.')[0]}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Stop Rental Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
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
                  child: const Text(
                    'Stop met huren',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Damage Report Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/damage_report', arguments: rental);
                  },
                  child: const Text(
                    'Schade melden',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
