import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jr_design_app/components/background_gradient_container.dart';
import 'package:jr_design_app/pages/dev_settings/test_chart.dart';

class RPMpage extends StatelessWidget {
  const RPMpage({Key? key}) : super(key: key);

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
            const SizedBox(height: 50.0), // Added space below the title
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.blueGrey,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const LineChartSample2(), // Added padding to the chart
              ),
            ),
            Expanded(
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('large_heart_data')
                    .doc('bpm')
                    .collection('session 03-28-24 12:04')
                    .doc('data')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  final List<dynamic> dataArray = data['data'] as List<dynamic>;

                  // Prepare lists for Y and X values
                  List<String> yValues = [];
                  List<String> xValues = [];
                  dataArray.forEach((map) {
                    yValues.add(map['y_value'] as String);
                    xValues.add(map['x_value'] as String);
                  });

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Time(s)')),
                        DataColumn(label: Text('Value (mmHg)')),
                      ],
                      rows: List<DataRow>.generate(
                        yValues.length,
                        (int index) => DataRow(
                          cells: [
                            DataCell(Text(xValues[index])),
                            DataCell(Text(yValues[index])),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page (Home page)
                Navigator.pop(context);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
