import 'package:flutter/material.dart';

import '../../pages/dev_settings/settings_page.dart'; // Import the settingsPage.dart
// Import the RPMpage.dart
// Import the RPMpage.dart
// Import the RPMpage.dart
// Import the RPMpage.dart

import '../../components/background_gradient_container.dart';

typedef OnDataBoxPressedCallback = void Function(BuildContext context);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        // basically the header
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                width: 86.0), // Add some space between the logo and text
            Image.asset(
              'assets/images/logo.png',
              height: 50.0,
            ),
            const SizedBox(
                width: 5.0), // Add some space between the logo and text
            const Text(
              'Affinity',
              style: TextStyle(
                fontSize: 30.0,
              ),
// Add some space between the logo and text
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 30.0), // Adjust the left padding as needed
            child: IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 50.0, // Adjust the size as needed
              onPressed: () {
                // Navigate to the settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: BackgroundGradientContainer(
        // custom class to have gradient already
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).padding.top + kToolbarHeight),
              _buildDataBox(context,
                  label: 'RPM',
                  value: '100',
                  iconPath: 'images/Blood.png', onPressed: (context) {
                Navigator.pushNamed(context, '/RPMpage');
              }),
              _buildDataBox(context,
                  label: 'PSI',
                  value: '50',
                  iconPath: 'assets/images/Heart.png', onPressed: (context) {
                Navigator.pushNamed(context, '/PSIpage');
              }),
              _buildDataBox(context,
                  label: 'Battery',
                  value: '97%',
                  iconPath: 'assets/images/Battery.png', onPressed: (context) {
                Navigator.pushNamed(context, '/BatteryPage');
              }),
              _buildDataBox(context,
                  label: 'GPM',
                  value: '100',
                  iconPath: 'assets/images/Flow.png', onPressed: (context) {
                Navigator.pushNamed(context, '/GPMpage');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataBox(BuildContext context,
      {required String label,
      required String value,
      required String iconPath,
      required OnDataBoxPressedCallback onPressed}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width /
          1.5, // size of the box determined by number at the back
      child: GestureDetector(
        onTap: () {
          // Navigate to the desired page using the provided callback
          onPressed(context);
        },
        child: Container(
          //width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[200],
          ),
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                height: 100.0,
                width: 100.0,
              ),
              //const SizedBox(width: 10.0), // Add some space between the icon and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 70, 163, 205),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
