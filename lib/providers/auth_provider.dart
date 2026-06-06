import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/storage_service.dart';

enum AuthStatus { unauthenticated, authenticating, authenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  User? _user;
  AuthStatus _status = AuthStatus.unauthenticated;
  String? _errorMessage;

  User? get user => _user;
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _checkPersistence();
  }

  Future<void> _checkPersistence() async {
    final token = await _storageService.getToken();
    if (token != null) {
      final info = await _storageService.getUserInfo();
      if (info['name'] != null && info['email'] != null) {
        _user = User(name: info['name']!, email: info['email']!);
        _status = AuthStatus.authenticated;
        notifyListeners();
      }
    }
  }

  Future<void> login(String email, String password) async {
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        _user = user;
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.error;
        _errorMessage = 'Credenciales inválidas';
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = 'Ocurrió un error en la conexión';
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
