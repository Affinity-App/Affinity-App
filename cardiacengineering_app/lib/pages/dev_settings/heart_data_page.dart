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
        title: const Text(
          'Heart ID',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        centerTitle: true, // Center the title horizontally
      ),
      body: BackgroundGradientContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50.0), // Adjusted height to move the logo up
              Image.asset(
                'assets/images/logo.png',
                height: 100.0,
              ),
              const SizedBox(
                  height: 20.0), // Adjusted spacing between the logo and text
              const Text(
                'Heart ID',
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 10.0), // Adjusted spacing between texts
              const Text(
                '401-365',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10.0), // Adjusted spacing between texts
              const Text(
                'Firmware Version',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 10.0), // Adjusted spacing between texts
              const Text(
                '3.2', // Display the firmware version here, will be updated with the actual version
                style: TextStyle(fontSize: 16.0),
              ),
              // You can display more information related to Heart ID here
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent, // Make bottom navigation bar transparent
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20.0,
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
}
