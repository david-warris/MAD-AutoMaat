import 'package:automaat_mad/models/car.dart';
import 'package:automaat_mad/screens/car_detail_screen.dart';
import 'package:automaat_mad/widgets/favourite_star.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class CarCard extends StatelessWidget {
  final Car car;
  final bool available;
  const CarCard({super.key, required this.car, required this.available});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: available
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CarDetailScreen(car: car)),
              );
            }
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFC107),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Car Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: car.picture != null && car.picture!.isNotEmpty
                      ? Image.memory(
                          base64Decode(car.picture!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(
                                Icons.directions_car,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.directions_car,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              // Car Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${car.brand.toUpperCase()} ${car.model.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'KILOMETER S',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      available ? 'HAND/AUTO' : 'UNAVAILABLE',
                      style: TextStyle(
                        fontSize: 12,
                        color: available ? Colors.grey[700] : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Price Section
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FavoriteStar(carId: car.id.toString()),
                  Text(
                    car.price != null ? '€${car.price!.toStringAsFixed(2)}' : 'N/A',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     if (car.isFavorite)
              //       const Icon(Icons.star, color: Colors.orange, size: 20)
              //     else
              //       const Icon(Icons.star_border, color: Colors.grey, size: 20),
              //     const Text(
              //       'PRIJS',
              //       style: TextStyle(
              //         fontSize: 12,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
