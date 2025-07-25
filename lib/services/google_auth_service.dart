// import 'dart:convert';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import '../models/auth_model.dart';
// import '../models/user_model.dart';
// import 'shared_prefs_service.dart';

// class GoogleAuthService {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email', 'profile'],
//   );

//   final String baseUrl; // Ganti dengan URL API sesungguhnya
//   final http.Client _client;
//   final SharedPrefsService _prefsService;

//   GoogleAuthService({
//     required this.baseUrl,
//     http.Client? client,
//     SharedPrefsService? prefsService,
//   }) : _client = client ?? http.Client(),
//        _prefsService = prefsService ?? SharedPrefsService();

//   // Sign in dengan Google
//   Future<AuthResponse> signInWithGoogle() async {
//     try {
//       // Trigger Google Sign In
//       final googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         // User canceled the sign-in flow
//         return AuthResponse.error('Google sign-in was canceled');
//       }

//       // Get authentication details
//       final googleAuth = await googleUser.authentication;
//       final idToken = googleAuth.idToken;

//       if (idToken == null) {
//         return AuthResponse.error('Failed to get Google ID token');
//       }

//       // Kirim token ID ke backend untuk verifikasi dan login
//       final response = await _client.post(
//         Uri.parse('$baseUrl/auth/google'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'id_token': idToken,
//         }),
//       );

//       final data = jsonDecode(response.body);
      
//       if (response.statusCode == 200) {
//         final authResponse = AuthResponse.fromJson(data);
        
//         // Simpan token ke SharedPreferences jika login berhasil
//         if (authResponse.success && authResponse.token != null) {
//           await _prefsService.setAuthToken(authResponse.token!);
          
//           // Jika API juga mengembalikan data user
//           if (authResponse.userData != null) {
//             final user = UserModel.fromJson(authResponse.userData!);
//             await _prefsService.setCurrentUser(jsonEncode(user.toJson()));
//           }
//         }
        
//         return authResponse;
//       } else {
//         return AuthResponse.error(data['message'] ?? 'Failed to authenticate with Google');
//       }
//     } catch (e) {
//       return AuthResponse.error('Google sign-in error: ${e.toString()}');
//     }
//   }

//   // Sign out dari Google
//   Future<bool> signOut() async {
//     try {
//       await _googleSignIn.signOut();
//       await _prefsService.clearAuthToken();
//       await _prefsService.clearCurrentUser();
//       return true;
//     } catch (e) {
//       print('Error signing out from Google: ${e.toString()}');
//       return false;
//     }
//   }

//   // Periksa apakah user sedang login dengan Google
//   Future<bool> isSignedIn() async {
//     return await _googleSignIn.isSignedIn();
//   }
// }
