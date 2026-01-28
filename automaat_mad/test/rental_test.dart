import 'package:flutter_test/flutter_test.dart';
import 'package:automaat_mad/models/rental.dart';
import 'package:automaat_mad/models/car.dart';

void main() {
  group('Rental Model Tests', () {
    test('Rental should be created with valid data', () {
      final rental = Rental(
        id: 1,
        latitude: 52.0,
        longitude: 13.0,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 5)),
        state: 'ACTIVE',
        customerId: 123,
        car: Car(id: 1, model: 'Test Car', brand: 'Test Brand', latitude: 1, longitude: 1),
      );

      expect(rental.id, 1);
      expect(rental.latitude, 52.0);
      expect(rental.longitude, 13.0);
      expect(rental.state, 'ACTIVE');
      expect(rental.customerId, 123);
    });

    test('Rental.fromJson should parse valid JSON', () {
      final json = {
        'id': 1,
        'latitude': 52.0,
        'longitude': 13.0,
        'fromDate': '2023-10-01T10:00:00Z',
        'toDate': '2023-10-06T10:00:00Z',
        'state': 'ACTIVE',
        'customer': {'id': 123},
        'car': {'id': 1, 'model': 'Test Car', 'brand': 'Test Brand'},
      };

      final rental = Rental.fromJson(json);

      expect(rental.id, 1);
      expect(rental.latitude, 52.0);
      expect(rental.longitude, 13.0);
      expect(rental.startDate, DateTime.parse('2023-10-01T10:00:00Z'));
      expect(rental.endDate, DateTime.parse('2023-10-06T10:00:00Z'));
      expect(rental.state, 'ACTIVE');
      expect(rental.customerId, 123);
    });

    test('Rental.fromJson should handle missing fields', () {
      final json = {
        'id': 1,
        'fromDate': '2023-10-01T10:00:00Z',
        'state': 'ACTIVE',
        'customer': {'id': 123},
        'car': {'id': 1, 'model': 'Test Car', 'brand': 'Test Brand'},
      };

      final rental = Rental.fromJson(json);

      expect(rental.latitude, isNull);
      expect(rental.longitude, isNull);
      expect(rental.endDate, isNull);
    });

    test('Rental.fromJson should use default values for missing fields', () {
      final json = {
        'customer': {'id': 123},
        'car': {'id': 1, 'model': 'Test Car', 'brand': 'Test Brand'},
      };

      final rental = Rental.fromJson(json);

      expect(rental.id, 0);
      expect(rental.state, 'UNKNOWN');
      expect(rental.startDate, isA<DateTime>());
    });

    test('Rental should throw error on invalid date format', () {
      final json = {
        'id': 1,
        'fromDate': 'invalid-date',
        'state': 'ACTIVE',
        'customer': {'id': 123},
        'car': {'id': 1, 'model': 'Test Car', 'brand': 'Test Brand'},
      };

      expect(() => Rental.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}