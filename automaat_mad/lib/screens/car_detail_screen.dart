import 'package:automaat_mad/models/car.dart';
import 'package:automaat_mad/models/rental.dart';
import 'package:automaat_mad/services/api_service.dart';
import 'package:automaat_mad/services/auth_service.dart';
import 'package:automaat_mad/services/rental_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;
  CarDetailScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${car.brand} ${car.model}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TODO: Auto afbeelding
            const SizedBox(height: 12),
            Text('Locatie: ${car.latitude}, ${car.longitude}'),
            const SizedBox(height: 12),
            ElevatedButton(
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
                    car: car, // hier zet je je originele car
                  );
                  Navigator.pushNamed(context, '/rental', arguments: rentalWithCar);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fout bij huren van auto: $e')),
                  );
                }
              },
              child: const Text('Start huur'),
            ),
          ],
        ),
      ),
    );
  }
}
