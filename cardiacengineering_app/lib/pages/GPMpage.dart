import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginPage.dart';

class GPMpage extends StatelessWidget {
  const GPMpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPM Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page (Home page)
                Navigator.pop(context);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
