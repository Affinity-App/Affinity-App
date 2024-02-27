// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:jr_design_app/pages/testChart.dart';
import 'settingsPage.dart'; // Import the settingsPage.dart
import 'BackgroundGradientContainer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        // basically the header
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 30.0,
            ),
            const SizedBox(
                width: 10.0), // Add some space between the logo and text
            const Text(
              'Affinity',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 15.0), // Adjust the left padding as needed
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150.0), // Move down to below the app bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDataBox(context, label: 'RPM', value: '1000'),
                _buildDataBox(context, label: 'Pressure', value: '50 PSI'),
                _buildDataBox(context, label: 'Battery', value: '90%'),
                _buildDataBox(context, label: 'Flow', value: '20 GPM'),
              ],
            ),
            const SizedBox(height: 20.0), // Add some space
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[200],
                ),
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Placeholder for graph with dropdown
                    // Replace this with your actual graph widget
                    const SizedBox(height: 20.0),
                    const Text(
                      'Graph with Dropdown',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),
                    // Dropdown placeholder
                    DropdownButton<String>(
                      items: ['Data 1', 'Data 2', 'Data 3'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                      },
                      hint: const Text('Select Data'),
                    ),
                    const SizedBox(height: 20.0),
                    // Graph placeholder
                    Expanded(
                      child: Center(
                        // uncomment for test chart link
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const testChart()),
                            );
                          },
                          style: ButtonStyle(
                // Add the animation controller
                animationDuration: const Duration(milliseconds: 200),
                // Shrink on press
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white10; // Shrink and visually indicate press
                    }
                    return Colors.transparent; // Use default overlay color
                  },
                ),
                // Scale the button down slightly on press
                padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0);
                    }
                    return const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0);
                  },
                ),
              ),
                          child: const Text('Go to testChart'),
                          
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataBox(BuildContext context,
      {required String label, required String value}) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[200],
        ),
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5.0),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
