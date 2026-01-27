import 'package:automaat_mad/models/car.dart';
import 'package:automaat_mad/models/rental.dart';
import 'package:automaat_mad/services/api_service.dart';
import 'package:automaat_mad/services/auth_service.dart';
import 'package:automaat_mad/services/rental_service.dart';
import 'package:automaat_mad/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;
  CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: '${car.brand} ${car.model}',
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
                      '${car.brand.toUpperCase()} ${car.model.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Locatie:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${car.latitude.toStringAsFixed(4)}, ${car.longitude.toStringAsFixed(4)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          car.isFavorite ? Icons.star : Icons.star_border,
                          color: car.isFavorite ? Colors.orange : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          car.isFavorite ? 'Favorite' : 'Add to favorites',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Start Rental Button
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
                      final api = Provider.of<ApiService>(context, listen: false);
                      final AuthService authService = Provider.of<AuthService>(context, listen: false);
                      final customerId = authService.user?.id;
                      debugPrint('Customer ID: $customerId');
                      final response = await RentalService(api: api).createRental(car: car, customerId: customerId);

                      final rentalWithCar = Rental(
                        id: response.id,
                        startDate: response.startDate,
                        endDate: response.endDate,
                        state: response.state,
                        customerId: response.customerId,
                        latitude: response.latitude,
                        longitude: response.longitude,
                        car: car,
                      );
                      Navigator.pushNamed(context, '/rental', arguments: rentalWithCar);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fout bij huren van auto: $e')),
                      );
                    }
                  },
                  child: const Text(
                    'Start huur',
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
