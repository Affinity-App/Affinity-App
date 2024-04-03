import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../components/background_gradient_container.dart';

class DeveloperMode extends StatelessWidget {
  const DeveloperMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Developer Mode',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ],
        ),
      ),
      body: BackgroundGradientContainer(
        child: SingleChildScrollView(
          // Added SingleChildScrollView to allow scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                width: double.infinity,
                'assets/images/logo.png',
                height: 1.0,
              ),
              const SizedBox(height: 100.0),
              DataTable(
                columnSpacing: 16.0,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Seconds',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Blood Pressure',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  // Added Temperature Column
                  DataColumn(
                    label: Text(
                      'BPM',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  // Added Pressure Column
                  DataColumn(
                    label: Text(
                      'Flow Rate',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Power Use',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  30,
                  (index) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text('${index + 1}')), // 'Seconds' column
                      DataCell(
                          Text('${index + 1}mmHg')), // 'Blood Pressure' column
                      DataCell(Text('${index + 2}BPM')), // 'BPM' column
                      DataCell(Text('${index + 3}L/min')), // 'Flow Rate' column
                      DataCell(
                          Text('${index + 3}W')), // 'Power Consumption' column
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
