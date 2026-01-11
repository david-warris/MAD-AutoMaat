import '../models/car.dart';
import 'api_service.dart';
import 'dart:convert';

class CarService {
  final ApiService api = ApiService();

  Future<List<Car>> fetchCars({String? token}) async {
    final response = await api.get('/api/cars', token: token);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Car.fromJson(e)).toList();
    } else {
      throw Exception('Kan auto’s niet ophalen');
    }
  }
}
