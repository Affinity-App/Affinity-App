// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:jr_design_app/components/data_box.dart';
import '../../pages/dev_settings/settings_page.dart';
import 'rpm_page.dart';
import 'psi_page.dart';
import 'battery_page.dart';
import 'gpm_page.dart';
import 'record_now_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import '../../components/background_gradient_container.dart';

typedef OnDataBoxPressedCallback = void Function(BuildContext context);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 86.0),
            Image.asset(
              'assets/images/logo.png',
              height: 50.0,
            ),
            const SizedBox(width: 5.0),
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
            padding: const EdgeInsets.only(right: 30.0),
            child: IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 50.0,
              onPressed: () {
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
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).padding.top +
                      kToolbarHeight +
                      20), // Added space
              DataBox(
                label: 'Blood Pressure',
                value: '000',
                iconPath: 'assets/images/Blood.png',
                onPressed: (context) {
                  Navigator.pushNamed(context, '/PSIpage');
                },
              ),
              DataBox(
                label: 'Heart Rate',
                value: '000',
                iconPath: 'assets/images/Heart.png',
                onPressed: (context) {
                  Navigator.pushNamed(context, '/RPMpage');
                },
              ),
              DataBox(
                label: 'Flow Rate',
                value: '00%',
                iconPath: 'assets/images/Flow.png',
                onPressed: (context) {
                  Navigator.pushNamed(context, '/GPMpage');
                },
              ),
              DataBox(
                label: 'Power Consumption',
                value: '000',
                iconPath: 'assets/images/Battery.png',
                onPressed: (context) {
                  Navigator.pushNamed(context, '/BatteryPage');
                },
              ),
              DataBox(
                label: 'Record Now',
                value: '',
                iconPath: 'assets/images/logo.png',
                onPressed: (context) {
                  Navigator.pushNamed(context, '/RecordNow');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
