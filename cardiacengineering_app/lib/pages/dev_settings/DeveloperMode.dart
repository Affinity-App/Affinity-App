//This page is now the 'Export Data' page
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../components/background_gradient_container.dart';
import 'package:csv/csv.dart';
import 'dart:convert';
import 'package:share/share.dart'; // Import the share package

class DeveloperMode extends StatefulWidget {
  const DeveloperMode({Key? key}) : super(key: key);

  @override
  _DeveloperModeState createState() => _DeveloperModeState();
}

class _DeveloperModeState extends State<DeveloperMode> {
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

  Future<void> generatePDF() async {
    try {
      final pdf = pw.Document();
      // Generate PDF content
      pdf.addPage(
        pw.Page(
          build: (context) => pw.TableHelper.fromTextArray(
            data: <List<String>>[
              <String>[
                'Seconds',
                'Blood Pressure',
                'BPM',
                'Flow Rate',
                'Power Use'
              ],
              ...List.generate(
                30,
                (index) => <String>[
                  '${index + 1}',
                  '${index + 1} mmHg',
                  '${index + 2} BPM',
                  '${index + 3} L/min',
                  '${index + 4} W',
                ],
              ),
            ],
          ),
        ),
      );

      // Save the PDF file
      final downloadsDirectory = await getDownloadsDirectory();
      if (downloadsDirectory != null) {
        final filePath = '${downloadsDirectory.path}/HeartData.pdf';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());

        // Open the PDF file (supported only on platforms with file opening capability)
        if (Platform.isAndroid ||
            Platform.isIOS ||
            Platform.isMacOS ||
            Platform.isWindows) {
          OpenFile.open(filePath);
        } else {
          print('File saved to: $filePath');
        }
      } else {
        throw 'Downloads directory is null.';
      }
    } catch (e) {
      print('Error generating PDF: $e');
      // Handle the error
    }
  }

  Future<void> generateCSV() async {
    try {
      // Prepare the data for CSV
      final List<List<String>> rows = <List<String>>[
        ['Seconds', 'Blood Pressure', 'BPM', 'Flow Rate', 'Power Use'],
        ...List.generate(
          30,
          (index) => [
            '${index + 1}',
            '${index + 1} mmHg',
            '${index + 2} BPM',
            '${index + 3} L/min',
            '${index + 4} W',
          ],
        ),
      ];

      // Convert data to CSV string
      String csv = const ListToCsvConverter().convert(rows);

      // Save the CSV file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/HeartData.csv';
      final file = File(filePath);
      await file.writeAsString(csv);

      print('CSV file saved to: $filePath'); // Confirm file path in logs

      // Share the file
      Share.shareFiles([filePath], text: 'Your CSV file is ready!');
    } catch (e) {
      print('Error generating CSV: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true, // Extend the body behind the app bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar elevation
        title: Center(
          // Center the title
          child: Text(
            'Export Data',
            style: TextStyle(
              fontSize: 30.0,
            ),
            textAlign: TextAlign.center, // Center the text horizontally
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<int>(
                    value: selectedOption,
                    onChanged: (int? newIndex) {
                      if (newIndex != null) {
                        changeSession(newIndex);
                      }
                    },
                    dropdownColor: Colors
                        .white, // Set dropdown box background to transparent
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
                  const SizedBox(width: 10.0), // Spacing before the DataTable
                  ElevatedButton(
                    onPressed: generatePDF,
                    child: Text('Generate PDF'),
                  ),
                  const SizedBox(width: 15.0), // Spacing between buttons
                  ElevatedButton(
                    onPressed: generateCSV,
                    child: Text('Generate CSV'),
                  ),
                ],
              ),
              SingleChildScrollView(
                // Wrap the DataTable in SingleChildScrollView
                scrollDirection: Axis.horizontal,
                child: DataTable(
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
                        DataCell(Text(
                            '${index + 1} mmHg')), // 'Blood Pressure' column
                        DataCell(Text('${index + 2} BPM')), // 'BPM' column
                        DataCell(
                            Text('${index + 3} L/min')), // 'Flow Rate' column
                        DataCell(Text('${index + 4} W')), // 'Power Use' column
                      ],
                    ),
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
