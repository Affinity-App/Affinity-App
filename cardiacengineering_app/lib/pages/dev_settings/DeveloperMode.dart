//This page is now the 'Export Data' page
import 'package:cloud_firestore/cloud_firestore.dart';
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
    'Session 5'
  ];
  List<DataRow> dataRows = []; // State variable to hold data rows

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is first created
  }

  Future<void> fetchData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot documentSnapshot = await firestore
        .collection('export_heart_data')
        .doc(options[selectedOption]) // Use selected session
        .get();

    var data =
        documentSnapshot.get('data') as List; // Cast the data field to a List

    List<DataRow> newRows = data.map((item) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Text((data.indexOf(item) + 1)
              .toString())), // Create an index number for 'Seconds'
          DataCell(Text('${item['blood pressure']}')), // 'Blood Pressure' value
          DataCell(Text('${item['heart rate']}')), // 'BPM' value
          DataCell(Text('${item['flow rate']}')), // 'Flow Rate' value
          DataCell(Text('${item['power consumption']}')), // 'Power Use' value
        ],
      );
    }).toList();

    setState(() {
      dataRows = newRows; // Update the state with the new rows
    });
  }

  void changeSession(int index) {
    setState(() {
      selectedOption = index;
    });
    fetchData(); // Fetch new data when session changes
  }

  Future<void> generatePDF() async {
    try {
      final pdf = pw.Document();

      // Convert DataRow to List<List<String>> for PDF generation
      List<List<String>> pdfData = [
        <String>[
          'Seconds',
          'Blood Pressure',
          'BPM',
          'Flow Rate',
          'Power Use'
        ], // headers
      ];

      // Add data from dataRows to pdfData
      for (DataRow row in dataRows) {
        List<String> rowData =
            row.cells.map((cell) => (cell.child as Text).data!).toList();
        pdfData.add(rowData);
      }

      // Generate PDF content using the dynamic data
      pdf.addPage(
        pw.Page(
          build: (context) => pw.TableHelper.fromTextArray(
            context: context,
            data: pdfData,
          ),
        ),
      );

      // Save the PDF file
      final downloadsDirectory = await getDownloadsDirectory();
      if (downloadsDirectory != null) {
        final filePath = '${downloadsDirectory.path}/HeartData.pdf';
        final file = File(filePath);
        await file.writeAsBytes(await pdf.save());

        // Open the PDF file
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
    }
  }

  Future<void> generateCSV() async {
    try {
      // Prepare headers for CSV
      final List<List<String>> rows = [
        ['Seconds', 'Blood Pressure', 'BPM', 'Flow Rate', 'Power Use']
      ];

      // Convert DataRow to List<List<String>> for CSV generation
      for (DataRow row in dataRows) {
        List<String> rowData =
            row.cells.map((cell) => (cell.child as Text).data!).toList();
        rows.add(rowData);
      }

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
                  rows: dataRows,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
