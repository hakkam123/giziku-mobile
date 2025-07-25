import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/auth_model.dart';
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
      final loginRequest = LoginRequest(email: email, password: password);
      final response = await _authRepository.signInWithEmailPassword(
        loginRequest,
      );

      if (response.success) {
        await _loadUserFromPrefs();
        return true;
      } else {
        _errorMessage = 'Login failed. Email or password incorrect.';
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Register dengan email dan password
  Future<bool> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final registerRequest = RegisterRequest(
        name: name,
        email: email,
        password: password,
      );
      final response = await _authRepository.signUpWithEmailPassword(
        registerRequest,
      );

      if (response.success) {
        await _loadUserFromPrefs();
        return true;
      } else {
        _errorMessage = response.message ?? 'Failed to sign up';
        return false;
      }
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
      final response = await _googleAuthService.signInWithGoogle();

      if (response.success) {
        await _loadUserFromPrefs();
        return true;
      } else {
        _errorMessage = response.message ?? 'Failed to sign in with Google';
        return false;
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
      // Sign out from repository
      await _authRepository.signOut();

      // Sign out from Google if using Google Sign-In
      if (_currentUser?.authProvider == AuthProvider.google) {
        await _googleAuthService.signOut();
      }

      // Clear user data
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