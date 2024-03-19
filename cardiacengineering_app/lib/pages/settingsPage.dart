import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginPage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 150.0,
            child: ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              style: ButtonStyle(
                 // backgroundColor
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 70, 163, 205)), // Set background color to blue
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
              child: const Text('Logout'),
            ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page (Home page)
                Navigator.pop(context);
              },
              style: ButtonStyle(
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
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error logging out: $e');
      // Handle error
    }
  }
}
