import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splashlogo_screens.dart';
import 'screens/profile_screen.dart';
import 'screens/profiles/edit_profile_screen.dart';
import 'providers/auth_provider_new.dart';
import 'providers/profile_provider.dart';
import 'repositories/auth_repository.dart';
import 'services/api_client.dart';
import 'services/auth_service_interface.dart';
import 'services/auth_service_impl.dart';
import 'services/shared_prefs_service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // SharedPrefsService
        Provider<SharedPrefsService>(
          create: (_) => SharedPrefsService(),
        ),
        // ApiClient
        // Provider<ApiClient>(
        //   create: (context) => ApiClient(
        //     prefsService: context.read<SharedPrefsService>(),
        //   ),
        // ),

        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            baseUrl: dotenv.env['API_URL'] ?? '',
            prefsService: context.read<SharedPrefsService>(),
          ),
        ),
        // AuthServiceImpla
        // Provider<IAuthService>(
        //   create: (context) => AuthServiceImpl(
        //     authRepository: context.read<AuthRepository>(),
        //     prefsService: context.read<SharedPrefsService>(),
        //   ),
        // ),
        // AuthProviderNew
        ChangeNotifierProvider<AuthProviderNew>(
          create: (context) => AuthProviderNew(
            authService: context.read<IAuthService>(),
          ),
        ),
        // Profile provider
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Giziku',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2AD882)),
          useMaterial3: true,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontFamily: 'Poppins'),
            displayMedium: TextStyle(fontFamily: 'Poppins'),
            displaySmall: TextStyle(fontFamily: 'Poppins'),
            headlineLarge: TextStyle(fontFamily: 'Poppins'),
            headlineMedium: TextStyle(fontFamily: 'Poppins'),
            headlineSmall: TextStyle(fontFamily: 'Poppins'),
            titleLarge: TextStyle(fontFamily: 'Poppins'),
            titleMedium: TextStyle(fontFamily: 'Poppins'),
            titleSmall: TextStyle(fontFamily: 'Poppins'),
            bodyLarge: TextStyle(fontFamily: 'Poppins'),
            bodyMedium: TextStyle(fontFamily: 'Poppins'),
            bodySmall: TextStyle(fontFamily: 'Poppins'),
            labelLarge: TextStyle(fontFamily: 'Poppins'),
            labelMedium: TextStyle(fontFamily: 'Poppins'),
            labelSmall: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: SplashLogoScreen(
          nextScreen: OnboardingScreen(
            nextScreen: const LoginScreen(),
          ),
        ),
        routes: {
          '/profile': (context) => const ProfileScreen(),
          '/edit_profile': (context) => const EditProfileScreen(),
        },
      ),
    );
  }
}