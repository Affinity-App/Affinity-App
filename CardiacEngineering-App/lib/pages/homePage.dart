import 'package:flutter/material.dart';
import 'package:jr_design_app/pages/testChart.dart';
import 'settingsPage.dart'; // Import the settingsPage.dart
import 'BackgroundGradientContainer.dart';


class HomePage extends StatelessWidget {
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
            SizedBox(width: 10.0), // Add some space between the logo and text
            Text(
              'Affinity',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: 15.0), // Adjust the left padding as needed
            child: IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 50.0, // Adjust the size as needed
              onPressed: () {
                // Navigate to the settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: BackgroundGradientContainer( // custom class to have gradient already
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150.0), // Move down to below the app bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDataBox(context, label: 'RPM', value: '1000'),
                _buildDataBox(context, label: 'Pressure', value: '50 PSI'),
                _buildDataBox(context, label: 'Battery', value: '90%'),
                _buildDataBox(context, label: 'Flow', value: '20 GPM'),
              ],
            ),
            SizedBox(height: 20.0), // Add some space
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey[200],
                ),
                margin: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Placeholder for graph with dropdown
                    // Replace this with your actual graph widget
                    SizedBox(height: 20.0),
                    Text(
                      'Graph with Dropdown',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
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
                      hint: Text('Select Data'),
                    ),
                    SizedBox(height: 20.0),
                    // Graph placeholder
                    Expanded(
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => testChart()
                                ),
                            );
                          },
                          child: Text('Go to testChart'),
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
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.0),
            Text(
              value,
              style: TextStyle(
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
