import 'package:automaat_mad/models/car.dart';
import 'package:flutter/material.dart';


class CarDetailScreen extends StatelessWidget {
  final Car car;
  const CarDetailScreen({super.key, required this.car});

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
              onPressed: () {
                // Ga naar rental screen
              },
              child: const Text('Huur auto'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ga naar schade melden
              },
              child: const Text('Schade melden'),
            ),
          ],
        ),
      ),
    );
  }
}