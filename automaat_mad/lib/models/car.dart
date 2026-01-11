class Car {
  final int id;
  final String brand;
  final String model;
  final double latitude;
  final double longitude;
  final bool isFavorite;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}