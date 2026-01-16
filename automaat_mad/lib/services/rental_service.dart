import 'package:automaat_mad/models/car.dart';
import 'package:automaat_mad/models/rental.dart';
import 'package:automaat_mad/services/auth_service.dart';
import 'api_service.dart';
import 'dart:convert';

class RentalService {
  final ApiService api;
  RentalService({required this.api});

  Future<List<Rental>> fetchRentals({String? token}) async {
    final response = await api.get('/api/rentals');
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Rental.fromJson(e)).toList();
    } else {
      throw Exception('Kan auto’s niet ophalen');
    }
  }

  Future<Rental> createRental({required Car car, required int? customerId}) async {
    final rentalData = {
      'state': 'RESERVED',
      'fromDate': DateTime.now().toIso8601String(),
      'customer': {'id': customerId},
      'car': {'id': car.id},
    };
    final response = await api.post('/api/rentals', rentalData);
    if (response.statusCode == 201) {
      return Rental.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Kan rental niet aanmaken');
    }
  }

  Future<Rental> updateRental(int id, Map<String, dynamic> rentalData) async {
    final response = await api.patch('/api/rentals/$id', rentalData);
    if (response.statusCode == 200) {
      return Rental.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Kan rental niet bijwerken');
    }
  }
}
