import 'package:flutter/material.dart';
import 'package:jr_design_app/pages/dev_settings/test_chart.dart';
import 'package:jr_design_app/pages/home_data/battery_page.dart';
import 'package:jr_design_app/pages/home_data/home_page.dart';
import 'package:jr_design_app/pages/home_data/psi_page.dart';
import 'package:jr_design_app/pages/home_data/rpm_page.dart';
import '../../components/background_gradient_container.dart';

class GPMpage extends StatefulWidget {
  const GPMpage({super.key});

  @override
  State<GPMpage> createState() => _GPMpageState();
}

class _GPMpageState extends State<GPMpage> {
  // Initially selected option
  String _selectedOption = 'Flow Rate GPM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: DropdownButton<String>(
          value: _selectedOption,
          icon: Text('\u25BC', style: TextStyle(color: Colors.grey[800], fontSize: 25.0)),
          underline: Container(height: 0),
          onChanged: (String? newValue) {
            setState(() {
              _selectedOption = newValue!;
            });
            // Navigate based on the selected option
            switch (newValue) {
              case 'Blood Pressure':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PSIpage()),
                );
                break;
              case 'RPM Data':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RPMpage()),
                );
                break;
              case 'Power Consumption':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Batterypage()),
                );
                break;
              // Add more cases for other options as needed
              // Default case for 'Blood Pressure' is to do nothing
              default:
                break;
            }
          },
          items: <String>['Blood Pressure', 'RPM Data', 'Flow Rate GPM', 'Power Consumption']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: const TextStyle(color: Colors.black, fontSize: 22.0)),
            );
          }).toList(),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: BackgroundGradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                  width: 2.0,
                  color: Colors.black,
                ),
                color: Colors.white,
              ),
              child: const LineChartSample2(),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the Home page
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ButtonStyle(
                  // backgroundColor
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(247, 169, 186, 1.0)), // set background color to pink
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set text color to white
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
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
