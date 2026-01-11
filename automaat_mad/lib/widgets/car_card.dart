import 'package:automaat_mad/models/car.dart';
import 'package:automaat_mad/screens/car_detail_screen.dart';
import 'package:flutter/material.dart';


class CarCard extends StatelessWidget {
  final Car car;
  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
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