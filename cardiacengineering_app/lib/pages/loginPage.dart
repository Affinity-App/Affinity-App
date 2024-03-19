import 'package:flutter/material.dart';
import 'package:jr_design_app/pages/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jr_design_app/services/auth_service.dart';

import 'createAccountPage.dart';
import 'homePage.dart';
import 'BackgroundGradientContainer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
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
        MaterialPageRoute(builder: (context) => HomePage()),
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
    }
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
                    labelStyle: TextStyle(color: Color.fromARGB(255, 70, 163, 205)),
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
                    labelStyle: TextStyle(color: Color.fromARGB(255, 70, 163, 205)), // Set text color to blue
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SquareTile(
              //       onTap: () => AuthService().signInWithGoogle(),
              //       imagePath: 'assets/images/google.png',
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20.0),
              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox (
                    width: 140.0,
                    child: ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                style: ButtonStyle(
                  // backgroundColor
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(247, 169, 186, 1.0)), // set background color to pink
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set text color to white
                // Add the animation controller
                animationDuration: const Duration(milliseconds: 200),
                // Shrink on press
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white10; // Shrink and visually indicate press
                    }
                    return Colors.transparent; // Use default overlay color
                  },
                ),
                // Scale the button down slightly on press
                padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0);
                    }
                    return const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0);
                  },
                ),
              ),
                child: const Text('Login'),
              ),
                  ),
              const SizedBox(height: 10.0),
              const SizedBox(width: 10.0), // Add some space between the login and create account buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateAccountPage()),
                  );
                },
                style: ButtonStyle(
                  // backgroundColor
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(247, 169, 186, 1.0)), // set background color to pink
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set text color to white
                // Add the animation controller
                animationDuration: const Duration(milliseconds: 200),
                // Shrink on press
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white10; // Shrink and visually indicate press
                    }
                    return Colors.transparent; // Use default overlay color
                  },
                ),
                // Scale the button down slightly on press
                padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0);
                    }
                    return const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0);
                  },
                ),
              ),
                child: const Text('Create Account'),
              ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}