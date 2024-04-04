import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../components/background_gradient_container.dart';

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back when arrow is pressed
          },
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
                  ElevatedButton(
                    onPressed: generatePDF,
                    style: ButtonStyle(
                // backgroundColor
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(
                        247, 169, 186, 1.0)), // set background color to pink
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.black), // Set text color to white
                // Add the animation controller
                animationDuration: const Duration(milliseconds: 200),
                // Shrink on press
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors
                          .white10; // Shrink and visually indicate press
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
                    child: Text('Generate PDF'),
                  ),
                ],
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
