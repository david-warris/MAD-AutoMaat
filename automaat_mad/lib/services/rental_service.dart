import 'package:automaat_mad/models/rental.dart';
import 'api_service.dart';
import 'dart:convert';

class RentalService {
  final ApiService api = ApiService();

  Future<List<Rental>> fetchRentals({String? token}) async {
    final response = await api.get('/api/rentals');
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Rental.fromJson(e)).toList();
    } else {
      throw Exception('Kan auto’s niet ophalen');
    }
  }
}
