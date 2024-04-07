import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'pages/home_data/home_page.dart';
import 'pages/login_auth/login_page.dart';
import 'pages/home_data/rpm_page.dart';
import 'pages/home_data/psi_page.dart';
import 'pages/home_data/battery_page.dart';
import 'pages/home_data/gpm_page.dart';
import 'services/firebase_options.dart';
import 'pages/dev_settings/developerMode.dart';

import 'components/themeProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

final TextStyle myAppTextStyle = TextStyle(
  fontFamily: 'RaleWay',
  fontSize: 16.0, // Set the desired font size
  // You can customize other properties like fontWeight, color, etc. here
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  textTheme: TextTheme(
    bodyText1: myAppTextStyle,
    bodyText2: myAppTextStyle,
    // You can assign the custom text style to various text themes as needed
  ),
  // Add other customizations for the light theme here
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.lightGreen,
  textTheme: TextTheme(
    bodyText1: myAppTextStyle,
    bodyText2: myAppTextStyle,
    // You can assign the custom text style to various text themes as needed
  ),
  // Add other customizations for the dark theme here
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Affinity',
      themeMode: themeProvider.themeMode, // Use the theme from the provider
      theme: lightTheme, //ThemeData.light(), // Use the light theme
      darkTheme: darkTheme, //ThemeData.dark(), // Use the dark theme

      // Define routes
      routes: {
        '/RPMpage': (context) => const RPMpage(),
        '/PSIpage': (context) => const PSIpage(),
        '/BatteryPage': (context) => const Batterypage(),
        '/GPMpage': (context) => const GPMpage(),
        '/DeveloperMode': (context) => const DeveloperMode(),
        '/home_page': (context) => const HomePage(),
      },
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
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
