import 'package:flutter/material.dart';
import 'package:jr_design_app/pages/dev_settings/test_chart.dart';
import '../../components/background_gradient_container.dart';
import '../../components/custom_button.dart';

class GPMpage extends StatelessWidget {
  const GPMpage({super.key}); //Flow Rate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: const Row(
          children: [
            Text(
              'Flow Rate GPM',
              style: TextStyle(
                fontSize: 30.0,
              ),
// Add some space between the logo and text
            ),
          ],
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
                color: Color.fromRGBO(247, 169, 186, 1.0),
              ),
              child: const LineChartSample2(),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page (Home page)
                Navigator.pop(context);
              },
              //**This portion changed
              style: CustomButton(
                backgroundColor:  Color.fromRGBO(247, 169, 186, 1.0),
                foregroundColor:  Colors.black, 
              ).toButtonStyle(),
              //
              child: const Text('Back to Home'),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
