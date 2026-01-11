import 'package:automaat_mad/models/car.dart';
import 'package:automaat_mad/services/car_service.dart';
import 'package:automaat_mad/widgets/car_card.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final CarService carService = CarService();

    return Scaffold(
      appBar: AppBar(title: const Text('Beschikbare auto’s')),
      body: FutureBuilder<List<Car>>(
        future: carService.fetchCars(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Fout bij laden'));
          }

          final cars = snapshot.data!;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) => CarCard(car: cars[index]),
          );
        },
      ),
    );
  }
}