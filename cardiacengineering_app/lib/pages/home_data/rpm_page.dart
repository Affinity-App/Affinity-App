import 'package:flutter/material.dart';
import 'package:jr_design_app/components/background_gradient_container.dart';
import 'package:jr_design_app/pages/dev_settings/test_chart.dart';

class RPMpage extends StatelessWidget {
  const RPMpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, //
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: const Text('RPM Data'),
      ),
      body: BackgroundGradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            // start from here
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
                // Navigate back to the previous page (Home page)
                Navigator.pop(context);
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
