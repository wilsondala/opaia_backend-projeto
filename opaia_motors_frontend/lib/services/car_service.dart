import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api.dart';
import '../models/car.dart';

class CarService {
  Future<List<Car>> getCars(String token) async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/cars/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Car.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao buscar carros: ${response.body}');
    }
  }

  Future<Car> getCarDetail(int carId, String token) async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/cars/$carId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return Car.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao buscar detalhes do carro: ${response.body}');
    }
  }

  Future<Car> createCar({
    required String marca,
    required String modelo,
    required int ano,
    required double preco,
    required String descricao,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('${Api.baseUrl}/cars/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'marca': marca,
        'modelo': modelo,
        'ano': ano,
        'preco': preco,
        'descricao': descricao,
      }),
    );

    if (response.statusCode == 201) {
      return Car.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao criar carro: ${response.body}');
    }
  }
}
