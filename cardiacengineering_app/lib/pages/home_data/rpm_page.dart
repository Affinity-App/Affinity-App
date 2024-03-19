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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.green,
                ),
                child: LineChartSample2(),
              ),
            ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the previous page (Home page)
                  Navigator.pop(context);
                },
                child: const Text('Back to Home'),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     // Navigate back to the previous page (Home page)
              //     Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => const lineChart()),
              //   );
              //   },
              //   child: const Text('Test Chart Page'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
