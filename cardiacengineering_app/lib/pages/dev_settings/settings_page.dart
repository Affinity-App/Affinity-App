import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:jr_design_app/pages/dev_settings/DeveloperMode.dart';
import 'package:jr_design_app/pages/dev_settings/heart_data_page.dart';
import 'package:jr_design_app/pages/home_data/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login_auth/login_page.dart';
import '../../components/background_gradient_container.dart';

import 'package:csv/csv.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  XFile? _profileImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Check for gallery permission
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted ||
        await Permission.photos.request().isGranted) {
      // Pick an image from the gallery
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _profileImage = image;
        });
      }
    } else {
      // Handle the permission denied case
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permission to access gallery denied'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        centerTitle: true, // Center align the title

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 50.0,
              onPressed: () {
                _pickImage();
              },
            ),
          ),
        ],
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
