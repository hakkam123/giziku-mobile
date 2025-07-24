import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider_new.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginNewScreen extends StatefulWidget {
  const LoginNewScreen({super.key});

  @override
  State<LoginNewScreen> createState() => _LoginNewScreenState();
}

class _LoginNewScreenState extends State<LoginNewScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoggingIn = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      _isLoggingIn = true;
      _errorMessage = null;
    });

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password';
        _isLoggingIn = false;
      });
      return;
    }

    try {
      final authProvider = Provider.of<AuthProviderNew>(context, listen: false);
      final success = await authProvider.signInWithEmailPassword(
        _emailController.text.trim(), 
        _passwordController.text
      );

      if (success) {
        // Navigate to home screen if login successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = authProvider.errorMessage ?? 'Login failed. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred during login: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  // Google sign-in is not implemented in the new auth provider
  Future<void> _signInWithGoogle() async {
    setState(() {
      _errorMessage = 'Google Sign-In is not available in this version.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Bagian atas dengan bentuk melengkung hijau
          Expanded(
            flex: 8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: -100, 
                  right: -100, 
                  height: 270,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2ECC71),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(300), // Radius lebih besar
                        bottomRight: Radius.circular(300), // Radius lebih besar
                      ),
                    ),
                  ),
                ),
                
                Positioned(
                  top: 110,
                  child: Container(
                    width: 120, // Ukuran logo sedikit lebih kecil
                    height: 120, // Untuk proporsi yang lebih baik
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC71).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/gizikulogo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Bagian bawah dengan tombol-tombol
          Expanded(
            flex: 6,
            child: Column(
              children: [
                // Display error message if there is one
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Email login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: _isLoggingIn 
                      ? null 
                      : _signInWithEmailAndPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 0),
                    ),
                    child: _isLoggingIn 
                      ? const SizedBox(
                          height: 20, 
                          width: 20, 
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Sign In with Email',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                  ),
                ),
                
                // Google login button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: _isLoggingIn ? null : _signInWithGoogle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      minimumSize: const Size(double.infinity, 0),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Sign In with Google',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                
                // Divider dengan text "or"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 40, right: 10),
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 40),
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                
                // Sign up button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: _isLoggingIn 
                      ? null 
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUpScreen()),
                          );
                        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71).withOpacity(0.1),
                      foregroundColor: const Color(0xFF2ECC71),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 0),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
