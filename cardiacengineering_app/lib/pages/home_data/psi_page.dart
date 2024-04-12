import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jr_design_app/components/background_gradient_container.dart';
import 'package:jr_design_app/pages/dev_settings/test_chart.dart';
import 'package:jr_design_app/pages/home_data/battery_page.dart';
import 'package:jr_design_app/pages/home_data/gpm_page.dart';
import 'package:jr_design_app/pages/home_data/home_page.dart';
import 'package:jr_design_app/pages/home_data/rpm_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PSIpage extends StatefulWidget {
  const PSIpage({Key? key}) : super(key: key);

  @override
  State<PSIpage> createState() => _PSIpageState();
}

class _PSIpageState extends State<PSIpage> {
  late int selectedSessionIndex = 0;
  final List<String> sessionNames = [
    "session 04-04-24 07:06",
    "session 04-04-24 07:10",
    "session 04-04-24 07:23",
    "session 04-04-24 07:24",
    "session 04-04-24 07:25",
    "live session"
  ];

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
          value: 'Blood Pressure', // Default value is 'RPM Data'
          icon: Text('\u25BC',
              style: TextStyle(color: Colors.grey[800], fontSize: 25.0)),
          underline: Container(height: 0),
          onChanged: (String? newValue) {
            setState(() {
              // Navigate based on the selected option
              switch (newValue) {
                case 'RPM Data':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RPMpage()),
                  );
                  break;
                case 'Flow Rate GPM':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GPMpage()),
                  );
                  break;
                case 'Power Consumption':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Batterypage()),
                  );
                  break;
                // Add more cases for other options as needed
                // Default case for 'Blood Pressure' is to do nothing
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
              child: Text(value,
                  style: TextStyle(
                      color: value == 'Blood Pressure'
                          ? Colors.red
                          : Colors.black, // Set selected option to red
                      fontSize: 22.0)),
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
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: BackgroundGradientContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100.0), // Added space below the title
            Container(
              decoration: const BoxDecoration(
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold), // Make text bold
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16.0), // Added spacing below the dropdown

            //code responsible for dynamic graph
            Container(
              height: 200, // Set a fixed height for the chart container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                  width: 2.0,
                  color: Colors.black,
                ),
                color: Colors.white,
              ),
              padding:
                  const EdgeInsets.all(8.0), // Padding inside the container
              margin: const EdgeInsets.symmetric(
                  horizontal: 16.0), // Margin around the container
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('large_heart_data')
                    .doc('blood pressure')
                    .collection(sessionNames[selectedSessionIndex])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final documents = snapshot.data!.docs;
                  List<FlSpot> systolicSpots = [];
                  List<FlSpot> diastolicSpots = [];

                  for (var document in documents) {
                    final data = document.data() as Map<String, dynamic>;
                    final xValueString = data['x_value'] as String? ?? '0';
                    final yValueString = data['y_value'] as String? ?? '0/0';

                    final xValue = double.tryParse(xValueString) ?? 0.0;
                    final bloodPressureValues = yValueString.split('/');
                    if (bloodPressureValues.length == 2) {
                      final systolicValue =
                          double.tryParse(bloodPressureValues[0]) ?? 0.0;
                      final diastolicValue =
                          double.tryParse(bloodPressureValues[1]) ?? 0.0;

                      systolicSpots.add(FlSpot(xValue, systolicValue));
                      diastolicSpots.add(FlSpot(xValue, diastolicValue));
                    }
                  }

                  return LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 10,
                        verticalInterval: 5,
                        getDrawingHorizontalLine: (value) {
                          return const FlLine(
                            color: Color.fromARGB(255, 29, 35, 53),
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return const FlLine(
                            color: Color.fromARGB(255, 29, 35, 53),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30, // space for the bottom titles
                            interval: 1, // interval between each title
                            getTitlesWidget: bottomTitleWidgets,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: leftTitleWidgets,
                            reservedSize: 42,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: const Color.fromARGB(
                                255, 77, 55, 73)), // chart border outline color
                      ),
                      minX: 0,
                      maxX: 30,
                      minY: 60,
                      maxY: 140,
                      lineBarsData: [
                        LineChartBarData(
                          spots: systolicSpots,
                          isCurved: true,
                          color: Colors.red[400]!, // Systolic color
                          barWidth: 4,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color.fromARGB(
                                151, 239, 154, 154), // Systolic area color
                          ),
                        ),
                        LineChartBarData(
                          spots: diastolicSpots,
                          isCurved: true,
                          color: Colors.blue[400]!, // Diastolic color
                          barWidth: 4,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color.fromARGB(
                                151, 154, 183, 239), // Diastolic area color
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('large_heart_data')
                      .doc('blood pressure')
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
                      xValues.add(map['x-value'] as String);
                    });

                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          headingTextStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          columns: [
                            const DataColumn(label: Text('Time(s)')),
                            const DataColumn(label: Text('Value (mmHg)')),
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    // initializes font/text
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text('0', style: style);
        break;
      case 10:
        text = const Text('10', style: style);
        break;
      case 20:
        text = const Text('20', style: style);
        break;
      case 30:
        text = const Text('30', style: style);
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    // initializes font/text
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;

    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 20:
        text = '20';
        break;
      case 40:
        text = '40';
        break;
      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;
      case 100:
        text = '100';
        break;
      case 120:
        text = '120';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.center);
  }
}
