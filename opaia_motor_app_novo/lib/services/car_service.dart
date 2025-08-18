import 'dart:convert';
import 'package:http/http.dart' as http;

class CarService {
  static Future<List<dynamic>> listarCarros(String token) async {
    final url = Uri.parse('http://localhost:8000/cars/');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> carros = jsonDecode(response.body);
      return carros;
    } else {
      throw Exception('Falha ao listar carros: ${response.statusCode}');
    }
  }
}
