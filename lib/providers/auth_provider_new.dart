import 'package:flutter/material.dart';
import '../models/api_response.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';
import '../services/auth_service_interface.dart';

enum AuthStatus {
  initial,
  authenticating,
  authenticated,
  unauthenticated,
  error
}

class AuthProviderNew extends ChangeNotifier {
  final IAuthService _authService;
  
  AuthStatus _status = AuthStatus.initial;
  UserModel? _currentUser;
  String? _errorMessage;
  bool _isLoading = false;

  AuthProviderNew({
    required IAuthService authService,
  }) : _authService = authService;

  // Getters
  AuthStatus get status => _status;
  UserModel? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _status == AuthStatus.authenticated;

  // Initialize the auth state
  Future<void> init() async {
    _setLoading(true);
    final isAuthenticated = await _authService.isAuthenticated();
    
    if (isAuthenticated) {
      final userResponse = await _authService.getCurrentUser();
      if (userResponse.success && userResponse.data != null) {
        _currentUser = userResponse.data;
        _status = AuthStatus.authenticated;
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } else {
      _status = AuthStatus.unauthenticated;
    }
    _setLoading(false);
  }

  // Sign in with email and password
  Future<bool> signInWithEmailPassword(String email, String password) async {
    _setLoading(true);
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    
    final request = LoginRequest(email: email, password: password);
    final response = await _authService.signIn(request);
    
    return _handleAuthResponse(response);
  }

  // Sign up with email and password
  Future<bool> signUpWithEmailPassword({
    required String email, 
    required String password, 
    required String name,
    String? phoneNumber,
    String? birthDate,
    String? gender,
  }) async {
    _setLoading(true);
    _status = AuthStatus.authenticating;
    _errorMessage = null;
    
    final request = RegisterRequest(
      email: email, 
      password: password,
      name: name,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      gender: gender,
    );
    
    final response = await _authService.signUp(request);
    
    return _handleAuthResponse(response);
  }

  // Sign out
  Future<bool> signOut() async {
    _setLoading(true);
    final response = await _authService.signOut();
    
    if (response.success) {
      _currentUser = null;
      _status = AuthStatus.unauthenticated;
      _setLoading(false);
      return true;
    } else {
      _errorMessage = response.message ?? 'Failed to sign out';
      _setLoading(false);
      return false;
    }
  }

  // Refresh the auth token
  Future<bool> refreshToken() async {
    _setLoading(true);
    final response = await _authService.refreshToken();
    
    return _handleAuthResponse(response);
  }

  // Get user profile
  Future<void> refreshUserProfile() async {
    if (!isLoggedIn) return;
    
    _setLoading(true);
    final response = await _authService.getCurrentUser();
    
    if (response.success && response.data != null) {
      _currentUser = response.data;
    } else {
      // If getting user profile fails, we might need to refresh token or sign out
      if (response.statusCode == 401) {
        await refreshToken();
      }
    }
    _setLoading(false);
  }

  // Helper method to handle authentication responses
  bool _handleAuthResponse(ApiResponse<UserModel> response) {
    if (response.success && response.data != null) {
      _currentUser = response.data;
      _status = AuthStatus.authenticated;
      _errorMessage = null;
      _setLoading(false);
      notifyListeners();
      return true;
    } else {
      _status = AuthStatus.error;
      _errorMessage = response.message ?? 'Authentication failed';
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // Helper to set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
