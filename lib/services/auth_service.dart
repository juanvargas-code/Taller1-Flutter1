import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'storage_service.dart';

class AuthService {
  final String baseUrl = 'https://parking.visiontic.com.co/api';
  final StorageService _storageService = StorageService();

  Future<User?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Asumiendo estructura común: { access_token: "...", user: { ... } }
        // Se ajustará si la API difiere tras pruebas.
        final String? token = data['access_token'];
        final userData = data['user'];

        if (token != null && userData != null) {
          final user = User.fromJson(userData);
          
          // Guardar localmente
          await _storageService.saveToken(token);
          await _storageService.saveUserInfo(user.name, user.email);
          
          return user;
        }
      }
      return null;
    } catch (e) {
      print('Error en login: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storageService.clearAll();
    // Opcional: Llamar endpoint de logout de la API si se requiere invalidar en backend
  }
}
