import 'package:flutter/material.dart';
import 'services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/login_auth/login_page.dart'; // Import the loginPage.dart file
import 'pages/home_data/rpm_page.dart'; // Import the RPMpage.dart file
import 'pages/home_data/psi_page.dart'; // Import the RPMpage.dart file
import 'pages/home_data/battery_page.dart'; // Import the RPMpage.dart file
import 'pages/home_data/gpm_page.dart'; // Import the RPMpage.dart file

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
        '/RPMpage': (context) => const RPMpage(),
        '/PSIpage': (context) => const PSIpage(),
        '/BatteryPage': (context) => const BatteryPage(),
        '/GPMpage': (context) => const GPMpage(),

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
