import 'package:automaat_mad/services/api_service.dart';

class RentalService {
  final ApiService apiService;

  RentalService({required this.apiService});

  Future<List<Rental>> getRentals() async {
    try {
      final response = await apiService.get('/api/rentals');
      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Rental.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

class Rental {
  final int id;
  final String code;
  final double longitude;
  final double latitude;
  final String fromDate;
  final String toDate;
  final String state;
  final List<Inspection> inspections;
  final Customer customer;
  final Car car;

  Rental({
    required this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.fromDate,
    required this.toDate,
    required this.state,
    required this.inspections,
    required this.customer,
    required this.car,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      id: json['id'],
      code: json['code'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      state: json['state'],
      inspections: (json['inspections'] as List).map((i) => Inspection.fromJson(i)).toList(),
      customer: Customer.fromJson(json['customer']),
      car: Car.fromJson(json['car']),
    );
  }
}

class Inspection {
  final int id;
  final String code;
  final int odometer;
  final String result;
  final String description;
  final String photo;
  final String photoContentType;
  final String completed;

  Inspection({
    required this.id,
    required this.code,
    required this.odometer,
    required this.result,
    required this.description,
    required this.photo,
    required this.photoContentType,
    required this.completed,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return Inspection(
      id: json['id'],
      code: json['code'],
      odometer: json['odometer'],
      result: json['result'],
      description: json['description'],
      photo: json['photo'],
      photoContentType: json['photoContentType'],
      completed: json['completed'],
    );
  }
}

class Customer {
  final int id;
  final int nr;
  final bool licenseChecked;
  final String lastName;
  final String firstName;
  final String from;

  Customer({
    required this.id,
    required this.nr,
    required this.licenseChecked,
    required this.lastName,
    required this.firstName,
    required this.from,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      nr: json['nr'],
      licenseChecked: json['licenseChecked'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      from: json['from'],
    );
  }
}

class Car {
  final int id;
  final String brand;
  final String model;
  final String picture;
  final String pictureContentType;
  final String fuel;
  final String options;
  final String licensePlate;
  final int engineSize;
  final int modelYear;
  final String since;
  final double price;
  final int nrOfSeats;
  final String body;
  final double longitude;
  final double latitude;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.picture,
    required this.pictureContentType,
    required this.fuel,
    required this.options,
    required this.licensePlate,
    required this.engineSize,
    required this.modelYear,
    required this.since,
    required this.price,
    required this.nrOfSeats,
    required this.body,
    required this.longitude,
    required this.latitude,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      picture: json['picture'],
      pictureContentType: json['pictureContentType'],
      fuel: json['fuel'],
      options: json['options'],
      licensePlate: json['licensePlate'],
      engineSize: json['engineSize'],
      modelYear: json['modelYear'],
      since: json['since'],
      price: json['price'],
      nrOfSeats: json['nrOfSeats'],
      body: json['body'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }
}