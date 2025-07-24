import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider(this._authService);

  // Forwarded getters
  bool get isLoading => _authService.isLoading;
  bool get isLoggedIn => _authService.isLoggedIn;
  String? get errorMessage => _authService.errorMessage;
  dynamic get currentUser => _authService.currentUser;

  // Initialize
  Future<void> init() async {
    await _authService.init();
    notifyListeners();
  }

  // Sign in with email and password
  Future<bool> signInWithEmailPassword(String email, String password) async {
    final result = await _authService.signInWithEmailPassword(email, password);
    notifyListeners();
    return result;
  }

  // Sign up with email and password
  Future<bool> signUpWithEmailPassword(String name, String email, String password) async {
    final result = await _authService.signUpWithEmailPassword(name, email, password);
    notifyListeners();
    return result;
  }

  // Sign in with Google
  Future<bool> signInWithGoogle() async {
    final result = await _authService.signInWithGoogle();
    notifyListeners();
    return result;
  }

  // Sign out
  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }

  // Refresh user profile
  Future<void> refreshUserProfile() async {
    await _authService.refreshUserProfile();
    notifyListeners();
  }

  // Reset error
  void resetError() {
    _authService.resetError();
    notifyListeners();
  }
}
