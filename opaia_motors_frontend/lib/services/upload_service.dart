import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/api.dart';

class UploadService {
  Future<String> uploadCarImage(int carId, File image, String token) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Api.baseUrl}/car-images/cars/$carId/images/'),
    );

    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    request.headers['Authorization'] = 'Bearer $token';

    var response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'Upload realizado com sucesso';
    } else {
      throw Exception('Falha no upload');
    }
  }
}
