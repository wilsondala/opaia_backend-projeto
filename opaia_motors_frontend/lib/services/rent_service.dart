import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api.dart';
import '../models/rent.dart';

class RentService {
  static get baseUrl => Api.baseUrl;

  /// Criar um novo aluguel
  static Future<Rent> rentCar({
    required int carId,
    required String startDate,
    required String endDate,
    required String token,
  }) async {
    final uri = Uri.parse('$baseUrl/rents/');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'car_id': carId,
        'start_date': startDate,
        'end_date': endDate,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Rent.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Falha ao criar aluguel: ${response.statusCode} - ${response.body}');
    }
  }

  /// Buscar todos os aluguéis do usuário logado
  static Future<List<Rent>> getMyRents({required String token}) async {
    final uri = Uri.parse('$baseUrl/rents/');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Rent.fromJson(json)).toList();
    } else {
      throw Exception(
          'Falha ao buscar aluguéis: ${response.statusCode} - ${response.body}');
    }
  }
}
