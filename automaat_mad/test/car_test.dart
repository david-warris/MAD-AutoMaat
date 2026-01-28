import 'package:flutter_test/flutter_test.dart';
import 'package:automaat_mad/models/car.dart';

void main() {
  group('Car', () {
    test('Car constructor creates instance with all parameters', () {
      final car = Car(
        id: 1,
        brand: 'Toyota',
        model: 'Camry',
        latitude: 52.3676,
        longitude: 4.9041,
        isFavorite: true,
      );

      expect(car.id, 1);
      expect(car.brand, 'Toyota');
      expect(car.model, 'Camry');
      expect(car.latitude, 52.3676);
      expect(car.longitude, 4.9041);
      expect(car.isFavorite, true);
    });

    test('Car.fromJson parses valid JSON correctly', () {
      final json = {
        'id': 1,
        'brand': 'Tesla',
        'model': 'Model 3',
        'latitude': 51.5074,
        'longitude': -0.1278,
        'isFavorite': true,
      };

      final car = Car.fromJson(json);

      expect(car.id, 1);
      expect(car.brand, 'Tesla');
      expect(car.model, 'Model 3');
      expect(car.isFavorite, true);
    });

    test('Car.fromJson converts string id to int', () {
      final json = {
        'id': '42',
        'brand': 'BMW',
        'model': 'X5',
        'latitude': 48.8566,
        'longitude': 2.3522,
      };

      final car = Car.fromJson(json);

      expect(car.id, 42);
      expect(car.id, isA<int>());
    });

    test('Car.fromJson throws exception when id is null', () {
      final json = {
        'id': null,
        'brand': 'Ford',
        'model': 'Mustang',
        'latitude': 40.7128,
        'longitude': -74.0060,
      };

      expect(() => Car.fromJson(json), throwsException);
    });

    test('Car.fromJson uses default values for missing optional fields', () {
      final json = {
        'id': 5,
        'brand': 'Honda',
        'model': 'Civic',
      };

      final car = Car.fromJson(json);

      expect(car.latitude, 0.0);
      expect(car.longitude, 0.0);
      expect(car.isFavorite, false);
    });
  });
}