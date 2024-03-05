import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/loginPage.dart'; // Import the loginPage.dart file
import 'pages/RPMpage.dart'; // Import the RPMpage.dart file
import 'pages/PSIpage.dart'; // Import the RPMpage.dart file
import 'pages/BatteryPage.dart'; // Import the RPMpage.dart file
import 'pages/GPMpage.dart'; // Import the RPMpage.dart file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define routes
      routes: {
        '/RPMpage': (context) => RPMpage(),
        '/PSIpage': (context) => PSIpage(),
        '/BatteryPage': (context) => BatteryPage(),
        '/GPMpage': (context) => GPMpage(),

        // Add other routes here
      },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
