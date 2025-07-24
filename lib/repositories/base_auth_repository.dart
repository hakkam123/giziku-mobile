import '../models/auth_model.dart';
import '../models/user_model.dart';

abstract class BaseAuthRepository {
  /// Login dengan email dan password
  Future<AuthResponse> signInWithEmailPassword(String email, String password);

  /// Register dengan email dan password
  Future<AuthResponse> signUpWithEmailPassword(String name, String email, String password);

  /// Cek apakah user sudah login
  Future<bool> isLoggedIn();

  /// Logout
  Future<bool> signOut();

  /// Get user profile
  Future<UserModel?> getUserProfile();
}
