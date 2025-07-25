import 'dart:convert';
import 'package:giziku/services/shared_prefs_service.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthRepository {
  final String baseUrl;
  final SharedPrefsService prefsService;

  AuthRepository({
    required this.baseUrl,
    required this.prefsService,
  });
  // Login: POST /api/auth/ > dapat token
  Future<String?> loginAndGetToken(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['token'];
      }
      return null;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Fetch profile user (contoh endpoint /api/profile/)
  Future<UserModel?> fetchProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/profile/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Fetch profile error: $e');
      return null;
    }
  }

    Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final body = {
        'name': name,
        'email': email,
        'password': password,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Register failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }
}