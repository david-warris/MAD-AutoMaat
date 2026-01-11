class Rental {
  final int id;
  final int carId;
  final int customerId;
  final DateTime startTime;
  final DateTime? endTime;

  Rental({
    required this.id,
    required this.carId,
    required this.customerId,
    required this.startTime,
    this.endTime,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      id: json['id'],
      carId: json['carId'],
      customerId: json['customerId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
    );
  }
}