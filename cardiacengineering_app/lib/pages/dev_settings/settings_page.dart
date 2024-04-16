//THIS IS NOW THE PROFILE PAGE

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:jr_design_app/pages/dev_settings/DeveloperMode.dart';
import 'package:jr_design_app/pages/dev_settings/heart_data_page.dart';
import 'package:jr_design_app/pages/home_data/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login_auth/login_page.dart';
import '../../components/background_gradient_container.dart';
import '../../components/custom_rating_bar.dart';
import 'package:getwidget/getwidget.dart';

import 'package:csv/csv.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _userRating = 0.0; // Add a default rating value
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
      ),
      body: BackgroundGradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              width: double.infinity,
              'assets/images/logo.png',
              height: 0.0,
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 100.0,
              onPressed: () {
                _pickImage();
              },
            ),
            const SizedBox(height: 80.0),

            //TILE 1
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: GestureDetector(
                onTap: () {
                  // Navigate to a different page when the tile is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HeartDataPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const GFListTile(
                    avatar: GFAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.favorite, color: Colors.white),
                    ),
                    titleText: 'Heart ID',
                    // subTitleText: 'Lorem ipsum dolor sit amet, consectetur adipiscing',
                    // icon: Icon(Icons.favorite),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            //TILE 2
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: GestureDetector(
                onTap: () {
                  // Navigate to a different page when the tile is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  HeartDataPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const GFListTile(
                    avatar: GFAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.notifications, color: Colors.white),
                    ),
                    titleText: 'Notifications',
                    // subTitleText: 'Lorem ipsum dolor sit amet, consectetur adipiscing',
                    //icon: Icon(Icons.favorite),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            //TILE 3
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: GestureDetector(
                onTap: () {
                  // Navigate to a different page when the tile is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const GFListTile(
                    avatar: GFAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.logout, color: Colors.white),
                    ),
                    titleText: 'Logout',
                  ),
                ),
              ),
            ),
            //COMMENTED OUT CODE FOR RATING BAR
            // const Text(
            //   'Rate Us',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            // CustomRatingBar(
            //   initialRating: _userRating,
            //   onRatingUpdate: (rating) {
            //     setState(() {
            //       _userRating = rating;
            //     });
            //   },
            // ),

            //OLD LOGOUT BUTTON
            // ElevatedButton(
            //   onPressed: () {
            //     _logout(context);
            //   },
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStateProperty.all<Color>(
            //         Color.fromARGB(255, 247, 169, 186)),
            //     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            //   ),
            //   child: const Text('Logout'),
            // ),
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
