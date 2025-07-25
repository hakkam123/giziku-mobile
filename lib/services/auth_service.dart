import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import 'shared_prefs_service.dart';

class AuthService extends ChangeNotifier {
  final AuthRepository _authRepository;
  final SharedPrefsService _prefsService;

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;
  String? get errorMessage => _errorMessage;

  AuthService({
    required AuthRepository authRepository,
    SharedPrefsService? prefsService,
  })  : _authRepository = authRepository,
        _prefsService = prefsService ?? SharedPrefsService();

  // Login: dapatkan token, simpan, fetch profile
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final token = await _authRepository.loginAndGetToken(email, password);
      if (token != null) {
        await _prefsService.saveToken(token);
        // Fetch profile dengan token
        final profile = await _authRepository.fetchProfile(token);
        if (profile != null) {
          _currentUser = profile;
          _errorMessage = null;
          notifyListeners();
          return true;
        } else {
          _errorMessage = 'Failed to fetch user profile.';
        }
      } else {
        _errorMessage = 'Login failed. Email or password incorrect.';
      }
      return false;
    } catch (e) {
      _errorMessage = 'An error occurred during login.';
      print('Login error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Cek login saat startup
  Future<void> loadUserFromPrefs() async {
    _isLoading = true;
    notifyListeners();
    try {
      final token = await _prefsService.getToken();
      if (token != null) {
        final profile = await _authRepository.fetchProfile(token);
        if (profile != null) {
          _currentUser = profile;
        }
      }
    } catch (e) {
      print('Error load user: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _prefsService.removeToken();
      _currentUser = null;
    } catch (e) {
      print('Sign out error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String? role,
    String? phone,
    String? address,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authRepository.register(
        name: name,
        email: email,
        password: password,
      );
      if (success) {
        return true;
      } else {
        _errorMessage = "Registration failed";
        return false;
      }
    } catch (e) {
      _errorMessage = "Error during registration";
      print('Register error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  // Reset error
  void resetError() {
    _errorMessage = null;
    notifyListeners();
  }
}