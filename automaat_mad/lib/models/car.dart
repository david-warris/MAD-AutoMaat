class Car {
  final int id;
  final String brand;
  final String model;
  final double latitude;
  final double longitude;
  final bool isFavorite;
  final String? picture;
  final String? pictureContentType;
  final double? price;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
    this.picture,
    this.pictureContentType,
    this.price,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
  final rawId = json['id'];

  if (rawId == null) {
    throw Exception('Car.fromJson: id is null → $json');
  }

  return Car(
    id: rawId is int ? rawId : int.parse(rawId.toString()),
    brand: json['brand']?.toString() ?? '',
    model: json['model']?.toString() ?? '',
    latitude: (json['latitude'] ?? 0).toDouble(),
    longitude: (json['longitude'] ?? 0).toDouble(),
    isFavorite: json['isFavorite'] ?? false,
    picture: json['picture']?.toString(),
    pictureContentType: json['pictureContentType']?.toString(),
    price: json['price'] != null ? (json['price'] as num).toDouble() : null,
  );
}
}