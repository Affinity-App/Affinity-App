import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jr_design_app/pages/home_data/record_now_page.dart';

import 'pages/home_data/home_page.dart';
import 'pages/login_auth/login_page.dart';
import 'pages/home_data/rpm_page.dart';
import 'pages/home_data/psi_page.dart';
import 'pages/home_data/battery_page.dart';
import 'pages/home_data/gpm_page.dart';
import 'services/firebase_options.dart';

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
        '/RecordNow': (context) => const RecordNow(),
      },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            // User is signed in
            return const HomePage(); // Navigate to home page
          } else {
            // User is not signed in
            return const LoginPage(); // Navigate to login page
          }
        }
      },
    );
  }
}
