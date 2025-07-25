import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  // static const String AUTH_TOKEN_KEY = 'auth_token1';
  // static const String USER_DATA_KEY = 'user_data';
  static const String _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }


  // // Simpan token autentikasi
  // Future<bool> setAuthToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.setString(AUTH_TOKEN_KEY, token);
  // }

  // // Ambil token autentikasi
  // Future<String?> getAuthToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(AUTH_TOKEN_KEY);
  // }

  // // Hapus token autentikasi
  // Future<bool> clearAuthToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.remove(AUTH_TOKEN_KEY);
  // }

  // // Simpan data user saat ini (dalam bentuk JSON string)
  // Future<bool> setCurrentUser(String userJson) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.setString(USER_DATA_KEY, userJson);
  // }

  // // Ambil data user saat ini
  // Future<String?> getCurrentUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(USER_DATA_KEY);
  // }

  // // Hapus data user saat ini
  // Future<bool> clearCurrentUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.remove(USER_DATA_KEY);
  // }

  // // Hapus semua data shared preferences
  // Future<bool> clearAll() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.clear();
  // }
}
