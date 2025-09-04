// lib/models/user.dart
class UserOut {
  final int id;
  final String email;
  final String fullName;

  UserOut({
    required this.id,
    required this.email,
    required this.fullName,
  });

  // Construtor para criar a partir de JSON
  factory UserOut.fromJson(Map<String, dynamic> json) {
    return UserOut(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'],
    );
  }

  // Converte o objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
    };
  }
}
