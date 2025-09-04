class Rent {
  final int id;
  final int userId;
  final int carId;
  final String startDate;
  final String endDate;
  final String status;

  Rent({
    required this.id,
    required this.userId,
    required this.carId,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      id: json['id'],
      userId: json['user_id'],
      carId: json['car_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'car_id': carId,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
    };
  }
}
