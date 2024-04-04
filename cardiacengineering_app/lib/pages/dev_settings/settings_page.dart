import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jr_design_app/pages/dev_settings/DeveloperMode.dart';
import 'package:jr_design_app/pages/dev_settings/heart_data_page.dart';
import 'package:provider/provider.dart';
import '../../components/ThemeProvider.dart';
import '../login_auth/login_page.dart';

import '../../components/background_gradient_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        centerTitle: true, // Center align the title
      ),
      body: BackgroundGradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Corrected asset path
              width: double.infinity,
              height: 100.0,
            ),
            const SizedBox(height: 100.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HeartDataPage()), // Removed const
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(247, 169, 186, 1.0)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Heart ID'),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeveloperMode()), // Removed const
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(247, 169, 186, 1.0)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Developer Mode'),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 247, 169, 186)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent, // Make bottom navigation bar transparent
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors
                  .transparent, // Set the color of the container to transparent
              child: Text(
                'App Version 1.2.0',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
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
        MaterialPageRoute(builder: (context) => LoginPage()), // Removed const
      );
    } catch (e) {
      print('Error logging out: $e');
      // Handle error
    }
  }
}
