// ignore_for_file: file_names, camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'createAccountPage.dart'; // Import the createAccountPage.dart
import 'homePage.dart'; // Import the homePage.dart
import 'BackgroundGradientContainer.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color gradientColor = const Color(0xFFA7C2F7);

    return Scaffold(
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
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Perform login logic here
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  // Navigate to homePage.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                  print('Email: $email, Password: $password');
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10.0), // Add some space between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to createAccountPage.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateAccountPage()),
                  );
                },
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
