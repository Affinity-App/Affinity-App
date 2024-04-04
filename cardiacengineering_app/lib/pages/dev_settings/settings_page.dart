import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jr_design_app/pages/dev_settings/DeveloperMode.dart';
import 'package:jr_design_app/pages/dev_settings/heart_data_page.dart';
import 'package:provider/provider.dart';
import '../../components/ThemeProvider.dart';
import '../login_auth/login_page.dart';

import '../../components/background_gradient_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 30.0,
              ),
// Add some space between the logo and text
            ),
          ],
        ),
      ),
      body: BackgroundGradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              width: double.infinity,
              'assets/images/logo.png',
              height: 100.0,
            ),
            const SizedBox(height: 100.0),
            // ElevatedButton(
            //   onPressed: () {
            //     // Access the ThemeProvider without passing a boolean value
            //     final themeProvider =
            //         Provider.of<ThemeProvider>(context, listen: false);
            //     themeProvider.toggleTheme(); // No argument needed
            //   },
            //   child: Text('Toggle Theme'),
            // ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HeartDataPage()),
                );
              },
              style: ButtonStyle(
                // backgroundColor
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(
                        247, 169, 186, 1.0)), // set background color to pink
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Set text color to white
                // Add the animation controller
                animationDuration: const Duration(milliseconds: 200),
                // Shrink on press
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors
                          .white10; // Shrink and visually indicate press
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
              child: const Text('Heart ID'),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the developer settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeveloperMode()),
                );
              },
              style: ButtonStyle(
                // backgroundColor
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(
                        247, 169, 186, 1.0)), // set background color to pink
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Set text color to white
                // Add the animation controller
                animationDuration: const Duration(milliseconds: 200),
                // Shrink on press
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors
                          .white10; // Shrink and visually indicate press
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
              child: const Text('Developer Mode'),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              style: ButtonStyle(
                // backgroundColor
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(
                        247, 169, 186, 1.0)), // set background color to pink
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Set text color to white
                // Add the animation controller
                animationDuration: const Duration(milliseconds: 200),
                // Shrink on press
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors
                          .white10; // Shrink and visually indicate press
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
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App Version 1.2.0',
              style: TextStyle(
                fontSize: 15.0,
              ),
// Add some space between the logo and text
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
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      print('Error logging out: $e');
      // Handle error
    }
  }
}
