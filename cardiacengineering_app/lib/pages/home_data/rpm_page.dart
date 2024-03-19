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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.green,
              ),
              child: LineChartSample2(),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page (Home page)
                Navigator.pop(context);
              },
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
