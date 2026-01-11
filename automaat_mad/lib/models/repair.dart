class Repair {
  final int id;
  final int rentalId;
  final String description;
  final int km;
  final String? photoUrl;

  Repair({
    required this.id,
    required this.rentalId,
    required this.description,
    required this.km,
    this.photoUrl,
  });

  factory Repair.fromJson(Map<String, dynamic> json) {
    return Repair(
      id: json['id'],
      rentalId: json['rentalId'],
      description: json['description'],
      km: json['km'],
      photoUrl: json['photoUrl'],
    );
  }
}