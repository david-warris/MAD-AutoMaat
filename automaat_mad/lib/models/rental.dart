class Rental {
  final int id;
  final double? latitude;
  final double? longitude;
  final DateTime startDate;
  final DateTime? endDate;
  final String state;
  final int customerId;
  final int carId;

  Rental({
    required this.id,
    this.latitude,
    this.longitude,    
    required this.startDate,
    this.endDate,
    required this.state,
    required this.customerId,
    required this.carId,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
  return Rental(
    id: json['id'] ?? 0,
    latitude: (json['latitude'] != null) ? (json['latitude'] as num).toDouble() : null,
    longitude: (json['longitude'] != null) ? (json['longitude'] as num).toDouble() : null,
    startDate: json['fromDate'] != null
        ? DateTime.parse(json['fromDate'])
        : DateTime.now(), // fallback, of throw error als je dat wilt
    endDate: json['toDate'] != null ? DateTime.parse(json['toDate']) : null,
    state: json['state'] ?? 'UNKNOWN',
    customerId: json['customer']?['id'] ?? 0,
    carId: json['car']?['id'] ?? 0,
  );
}

}