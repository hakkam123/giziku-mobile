// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import 'home_screen.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscureText = true;
//   bool _isLoggingIn = false;
//   String? _errorMessage;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _signIn() async {
//     setState(() {
//       _isLoggingIn = true;
//       _errorMessage = null;
//     });

//     if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
//       setState(() {
//         _errorMessage = 'Please fill in all fields';
//         _isLoggingIn = false;
//       });
//       return;
//     }

//     try {
//       final authProvider = Provider.of<AuthProvider>(context, listen: false);
//       final success = await authProvider.signInWithEmailPassword(
//         _emailController.text.trim(), 
//         _passwordController.text,
//       );

//       if (success) {
//         // Navigate to HomeScreen if login successful
//         Navigator.pushReplacement(
//           context, 
//           MaterialPageRoute(builder: (context) => const HomeScreen()),
//         );
//       } else {
//         setState(() {
//           _errorMessage = authProvider.errorMessage ?? 'Failed to sign in. Please try again.';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'An error occurred: ${e.toString()}';
//       });
//     } finally {
//       setState(() {
//         _isLoggingIn = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Back button
//               IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: () => Navigator.pop(context),
//                 padding: EdgeInsets.zero,
//                 constraints: const BoxConstraints(),
//               ),
              
//               const SizedBox(height: 30),
              
//               const Text(
//                 'Sign In',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
              
//               const SizedBox(height: 10),
              
//               const Text(
//                 'Enter your email and password to continue',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
              
//               const SizedBox(height: 30),
              
//               // Error message
//               if (_errorMessage != null)
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   margin: const EdgeInsets.only(bottom: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade100,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.error_outline, color: Colors.red),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           _errorMessage!,
//                           style: const TextStyle(
//                             color: Colors.red,
//                             fontFamily: 'Poppins',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
              
//               // Email Field
//               TextField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   prefixIcon: const Icon(Icons.email_outlined),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 15),
//                 ),
//               ),
              
//               const SizedBox(height: 20),
              
//               // Password Field
//               TextField(
//                 controller: _passwordController,
//                 obscureText: _obscureText,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: const Icon(Icons.lock_outline),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       _obscureText ? Icons.visibility : Icons.visibility_off,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _obscureText = !_obscureText;
//                       });
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 15),
//                 ),
//               ),
              
//               const SizedBox(height: 10),
              
//               // Forgot password
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     // TODO: Implementasi fitur lupa password
//                   },
//                   style: TextButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                     minimumSize: const Size(50, 30),
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   ),
//                   child: const Text(
//                     'Forgot Password?',
//                     style: TextStyle(
//                       color: Color(0xFF2ECC71),
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ),
//               ),
              
//               const SizedBox(height: 30),
              
//               // Sign in button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: _isLoggingIn ? null : _signIn,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF2ECC71),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: _isLoggingIn
//                       ? const SizedBox(
//                           height: 20,
//                           width: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             color: Colors.white,
//                           ),
//                         )
//                       : const Text(
//                           'Sign In',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Poppins',
//                           ),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
