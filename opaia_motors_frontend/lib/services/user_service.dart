import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/api.dart';

class UserService {
  Future<UserOut> getMe(String token) async {
    final response = await http.get(
      Uri.parse('${Api.baseUrl}/auth/me'),
      headers: Api.authHeaders(token),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserOut.fromJson(data);
    } else {
      throw Exception('Erro ao buscar usuário: ${response.body}');
    }
  }
}
