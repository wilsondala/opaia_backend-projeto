import 'package:http/http.dart' as http;

class RentService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  static Future<bool> rentCar(int carId, int userId) async {
    final url = Uri.parse('$baseUrl/alugueis/');
    final response = await http.post(
      url,
      body: {
        'car_id': carId.toString(),
        'user_id': userId.toString(),
      },
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
