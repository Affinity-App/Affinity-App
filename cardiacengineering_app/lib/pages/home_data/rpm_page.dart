import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jr_design_app/components/background_gradient_container.dart';
import 'package:jr_design_app/pages/dev_settings/test_chart.dart';

class RPMpage extends StatefulWidget {
  const RPMpage({Key? key}) : super(key: key);

  @override
  _RPMpageState createState() => _RPMpageState();
}

class _RPMpageState extends State<RPMpage> {
  late int selectedSessionIndex = 0;
  final List<String> sessionNames = [
    "session 03-28-24 12:04",
    "session 03-28-24 12:13",
    "session 03-28-24 12:16",
    "session 03-28-24 12:17",
    "session 03-28-24 12:21"
  ];

  void changeSession(int index) {
    setState(() {
      selectedSessionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents bottom overflow
      extendBodyBehindAppBar: true,
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
                // borderRadius: BorderRadius.circular(10.0),
                // border: Border.all(
                //     color: Colors.black, width: 5.0), // Set border thickness
                color: Colors
                    .transparent, // Set the container background to transparent
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<int>(
                value: selectedSessionIndex,
                onChanged: (int? newIndex) {
                  if (newIndex != null) {
                    changeSession(newIndex);
                  }
                },
                dropdownColor:
                    Colors.white, // Set dropdown box background to transparent
                items: List.generate(sessionNames.length, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                      sessionNames[index],
                      style: TextStyle(
                          fontWeight: FontWeight.bold), // Make text bold
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16.0), // Added spacing below the dropdown
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const LineChartSample2(), // Added padding to the chart
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('large_heart_data')
                      .doc('bpm')
                      .collection(sessionNames[selectedSessionIndex])
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
                    final List<dynamic> dataArray =
                        data['data'] as List<dynamic>;

                    // Prepare lists for Y and X values
                    List<String> yValues = [];
                    List<String> xValues = [];
                    dataArray.forEach((map) {
                      yValues.add(map['y_value'] as String);
                      xValues.add(map['x_value'] as String);
                    });

                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(
                            8.0), // Adjust the padding to include the border width
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: 2.0), // Adjust the border thickness
                          borderRadius:
                              BorderRadius.circular(10.0), // Set border radius
                        ),
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors
                                  .white), // Set the background color of the header row
                          headingTextStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight
                                  .bold), // Set the text style of the header row
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
                      ),
                    );
                  },
                ),
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
