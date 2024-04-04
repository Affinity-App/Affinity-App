import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login_auth/login_page.dart';

import '../../components/background_gradient_container.dart';

class HeartDataPage extends StatelessWidget {
  const HeartDataPage({Key? key}) : super(key: key);

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
              'Heart ID',
              style: TextStyle(
                fontSize: 30.0,
              ),
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
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page
                Navigator.pop(context);
              },
              style: ButtonStyle(
                // backgroundColor
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(
                        247, 169, 186, 1.0)), // set background color to pink
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.black), // Set text color to white
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
              child: const Text('Back'),
            ),
            const SizedBox(height: 30.0),
            // Display Heart ID information
            Text(
              'Heart ID Info:',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'Heart ID: 401-365',
              style: TextStyle(fontSize: 16.0),
            ),
            // You can display more information related to Heart ID here
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
            ),
          ],
        ),
      ),
    );
  }
}