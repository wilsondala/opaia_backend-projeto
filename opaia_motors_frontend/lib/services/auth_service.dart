import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  static const String baseUrl = "http://localhost:8000";

  // ============================
  // LOGIN
  // ============================
  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'username': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Retorna o token JWT
      return data['access_token'];
    } else if (response.statusCode == 401) {
      throw Exception('Credenciais inválidas');
    } else {
      throw Exception('Erro ao fazer login: ${response.body}');
    }
  }

  // ============================
  // OBTER DADOS DO USUÁRIO LOGADO
  // ============================
  static Future<UserOut?> getMe(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserOut(
        id: data['id'],
        email: data['email'],
        fullName: data['full_name'],
      );
    } else if (response.statusCode == 401) {
      throw Exception('Token inválido ou expirado');
    } else {
      throw Exception('Erro ao obter dados do usuário: ${response.body}');
    }
  }

  // ============================
  // REGISTRO
  // ============================
  static Future<bool> register(
      String email, String password, String fullName) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
        "full_name": fullName,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception('Dados inválidos ou usuário já existe');
    } else {
      throw Exception('Erro ao registrar usuário: ${response.body}');
    }
  }
}
