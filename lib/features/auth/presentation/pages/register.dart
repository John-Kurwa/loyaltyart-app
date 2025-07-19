import 'package:flutter/material.dart';
import 'package:loyaltyart/features/auth/presentation/pages/login_page.dart';
import 'package:loyaltyart/features/home/presentation/pages/home_page.dart';
// import 'package:provider/provider.dart';
// import '../../auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//   String email = '';
//   String password = '';
//   bool loading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Staff Registration')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Email'),
//                   onSaved: (val) => email = val ?? '',
//                   validator: (val) => val!.isEmpty ? 'Enter email' : null,
//                 ),
//                 TextFormField(
//                   decoration: const InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   onSaved: (val) => password = val ?? '',
//                   validator: (val) => val!.isEmpty ? 'Enter password' : null,
//                 ),
//                 const SizedBox(height: 16),
//                 loading
//                     ? const Center(child: CircularProgressIndicator())
//                     : ElevatedButton(
//                         child: const Text('Register'),
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             _formKey.currentState!.save();
//                             setState(() => loading = true);
//                             try {
//                               await Provider.of<AuthController>(context, listen: false)
//                                   .register(email, password);
//                               Navigator.pop(context);
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Registration failed: ${e.toString()}')),
//                               );
//                             }
//                             setState(() => loading = false);
//                           }
//                         },
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900, // Deep banking blue
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        elevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Email Field
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.blue.shade800,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.orangeAccent),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.blue.shade800,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.orangeAccent),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.blue.shade800,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.orangeAccent),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth.createUserWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Account created successfully!')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      } on FirebaseAuthException catch (e) {
                        String errorMessage;
                        if (e.code == 'weak-password') {
                          errorMessage = 'The password provided is too weak.';
                        } else if (e.code == 'email-already-in-use') {
                          errorMessage = 'The account already exists for that email.';
                        } else {
                          errorMessage = 'An error occurred. Please try again.';
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(errorMessage)),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),

                // Already have an account? Login
                TextButton(
                  onPressed: () {
                   Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                  },
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}