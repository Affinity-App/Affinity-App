import 'package:flutter/material.dart';

import '../../components/background_gradient_container.dart';

class RecordNow extends StatelessWidget {
  const RecordNow({super.key}); //Blood Pressure

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: const Row(
          children: [
            Text(
              'Recording',
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
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page (Home page)
                Navigator.pop(context);
              },
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
