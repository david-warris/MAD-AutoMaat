import 'package:automaat_mad/models/car.dart';
import 'package:automaat_mad/screens/car_detail_screen.dart';
import 'package:flutter/material.dart';


class CarCard extends StatelessWidget {
  final Car car;
  final bool available;
  const CarCard({super.key, required this.car, required this.available});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
        enabled: available,
        title: Text('${car.brand} ${car.model}'),
        subtitle: Text('Locatie: ${car.latitude}, ${car.longitude}'),
        trailing: Icon(car.isFavorite ? Icons.star : Icons.star_border),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => CarDetailScreen(car: car)
          ));
        },
      ),
    );
  }
}