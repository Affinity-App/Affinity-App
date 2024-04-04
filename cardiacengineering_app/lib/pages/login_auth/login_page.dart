import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'create_account_page.dart';
import 'reset_password_page.dart'; // Import the reset password page
import '../home_data/home_page.dart';
import '../../components/background_gradient_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Added _isLoading variable

  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      // Sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to home page if login is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // Handle login errors here
      print('Login failed: $e');
      // Show a snackbar or dialog to inform the user about the login failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to navigate to the password reset page
  void _navigateToResetPasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      body: BackgroundGradientContainer(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              Image.asset(
                'assets/images/logo.png',
                height: 100.0,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Affinity',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 70, 163, 205)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(
                            255, 70, 163, 205)), // Set text color to blue
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _signInWithEmailAndPassword,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromRGBO(
                      247, 169, 186, 1.0), // Set text color to white
                ),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : const Text('Login'),
              ),
              const SizedBox(height: 10.0),
              const SizedBox(
                  width:
                      10.0), // Add some space between the login and create account buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateAccountPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromRGBO(
                      247, 169, 186, 1.0), // Set text color to white
                ),
                child: const Text('Create Account'),
              ),
              // Button for navigating to the reset password page
              TextButton(
                onPressed: _navigateToResetPasswordPage,
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
