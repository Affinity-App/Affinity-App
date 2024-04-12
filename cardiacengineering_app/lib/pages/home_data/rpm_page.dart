import 'package:flutter/material.dart';
import 'package:jr_design_app/components/background_gradient_container.dart';
import 'package:jr_design_app/pages/dev_settings/test_chart.dart';
import 'package:jr_design_app/pages/home_data/battery_page.dart';
import 'package:jr_design_app/pages/home_data/gpm_page.dart';
import 'package:jr_design_app/pages/home_data/home_page.dart';
import 'package:jr_design_app/pages/home_data/psi_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    "session 03-28-24 12:21",
    "live session"
  ];
  String? selectedOption = 'RPM Data';  // Default value

  void changeSession(int index) {
    setState(() {
      selectedSessionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: DropdownButton<String>(
          value: selectedOption,
          icon: const Text('\u25BC',
              style: TextStyle(color: Colors.grey, fontSize: 25.0)),
          underline: Container(height: 0),
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue;
              switch (newValue) {
                case 'Blood Pressure':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PSIpage()),
                  );
                  break;
                case 'Flow Rate GPM':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GPMpage()),
                  );
                  break;
                case 'Power Consumption':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Batterypage()),
                  );
                  break;
                default:
                  break;
              }
            });
          },
          items: <String>[
            'Blood Pressure',
            'RPM Data',
            'Flow Rate GPM',
            'Power Consumption'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: value == selectedOption ? Colors.red : Colors.black, fontSize: 22.0),
              ),
            );
          }).toList(),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: BackgroundGradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<int>(
                value: selectedSessionIndex,
                onChanged: (int? newIndex) {
                  if (newIndex != null) {
                    changeSession(newIndex);
                  }
                },
                dropdownColor: Colors.white,
                items: List.generate(sessionNames.length, (index) {
                  return DropdownMenuItem<int>(
                    value: index,
                    child: Text(
                      sessionNames[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(width: 2.0, color: Colors.black),
                color: Colors.white,
              ),
              child: const LineChartSample2(),
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
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    final Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    final List<dynamic> dataArray = data['data'] as List<dynamic>;

                    List<String> yValues = [];
                    List<String> xValues = [];
                    dataArray.forEach((map) {
                      yValues.add(map['y_value'] as String);
                      xValues.add(map['x_value'] as String);
                    });

                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
                          headingTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          columns: const [
                            DataColumn(label: Text('Time(s)')),
                            DataColumn(label: Text('Value (bpm)')),
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
          ],
        ),
      ),
    );
  }
}
