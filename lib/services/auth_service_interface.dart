import '../models/api_response.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';

abstract class IAuthService {
  // Get the currently authenticated user
  Future<ApiResponse<UserModel>> getCurrentUser();
  
  // Sign in with email and password
  Future<ApiResponse<UserModel>> signIn(LoginRequest request);
  
  // Register a new user
  Future<ApiResponse<UserModel>> signUp(RegisterRequest request);
  
  // Sign out the current user
  Future<ApiResponse<bool>> signOut();
  
  // Check if user is authenticated
  Future<bool> isAuthenticated();
  
  // Refresh the authentication token
  Future<ApiResponse<UserModel>> refreshToken();
}
