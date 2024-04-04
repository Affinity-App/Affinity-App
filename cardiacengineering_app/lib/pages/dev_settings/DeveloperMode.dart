import 'package:flutter/material.dart';
import '../../../components/background_gradient_container.dart';

class DeveloperMode extends StatefulWidget {
  const DeveloperMode({Key? key}) : super(key: key);

  @override
  _DeveloperModeState createState() => _DeveloperModeState();
}

class _DeveloperModeState extends State<DeveloperMode> {
  String dropdownValue = ''; // Corrected variable name
  late int selectedOption = 0;
  final List<String> options = [
    'Session 1',
    'Session 2',
    'Session 3',
    'Session 4',
    'Session 5',
  ]; // Define custom dropdown options

  void changeSession(int index) {
    setState(() {
      selectedOption = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: const Text(
          'Developer Mode',
          style: TextStyle(
            fontSize: 30.0,
          ),
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
                'assets/images/logo.png',
                width: double.infinity,
                height: 0.0, // Adjusted height
              ),
              const SizedBox(height: 100.0), // Spacing before the DataTable
              DropdownButton<int>(
                value: selectedOption,
                onChanged: (int? newIndex) {
                  if (newIndex != null) {
                    changeSession(newIndex);
                  }
                },
                dropdownColor:
                    Colors.white, // Set dropdown box background to transparent
                items: List.generate(options.length, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                      options[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold), // Make text bold
                    ),
                  );
                }),
              ),
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
                  DataColumn(
                    label: Text(
                      'BPM',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
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
                          Text('${index + 1} mmHg')), // 'Blood Pressure' column
                      DataCell(Text('${index + 2} BPM')), // 'BPM' column
                      DataCell(
                          Text('${index + 3} L/min')), // 'Flow Rate' column
                      DataCell(Text('${index + 4} W')), // 'Power Use' column
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
