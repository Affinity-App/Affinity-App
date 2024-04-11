import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../components/background_gradient_container.dart';
import '../../services/firebase_data.dart';

class lineChart extends StatelessWidget {
  final darkBlueColor = const Color.fromARGB(255, 29, 35, 53);

  const lineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Line Chart'),
        backgroundColor: Colors.transparent,
      ),
      body: BackgroundGradientContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 250.0),
            ),
          ],
        ),
      ),
    );
  }
}

//  LineChartSample2(),
class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.red[400]!,
    Colors.red[200]!,
  ];
  bool showAvg = false;
  Future<List<FlSpot>>? chartData; // Future to hold fetched data

  @override
  void initState() {
    super.initState();
    fetchData(); // Call data fetching method on initialization
  }

  Future<void> fetchData() async {
    final data =
        await fetchDataFromFirebaseOld(); // Call your Firebase fetching method
    setState(() {
      chartData = convertDataToFlSpots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 12,
              top: 40,
              bottom: 12,
            ),
            child: chartData == null
                ? const Center(child: CircularProgressIndicator())
                : FutureBuilder<List<FlSpot>>(
                    future: chartData!,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching data'));
                      }

                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return LineChart(
                            showAvg ? avgData(data) : mainData(data));
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              '', // avg button text
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
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

  LineChartData mainData(List<FlSpot> data) {
    return LineChartData(
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
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: data,
          // const [
          //   FlSpot(0, 10),
          //   FlSpot(15, 20),
          //   FlSpot(20, 55),
          //   FlSpot(30, 50),
          //   FlSpot(40, 30),
          //   FlSpot(50, 40),
          //   FlSpot(60, 45),
          // ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 4, // width of the line, 4 default
          isStrokeCapRound: true,
          dotData: const FlDotData(
            // show the dot of each point
            show: true,
          ),
          belowBarData: BarAreaData(
            // area below the line gradient
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData(List<FlSpot> data) {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 32,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 60,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future<List<FlSpot>> fetchDataFromFirebaseOld() async {
  final collectionRef =
      FirebaseFirestore.instance.collection('data_1'); // collection name
  final querySnapshot =
      await collectionRef.get(); // getting all documents from the collection

  final data = querySnapshot.docs
      .map((doc) => doc.data())
      .toList(); // converting documents to list of maps

  // Sort data based on xField in ascending order
  data.sort((a, b) => a['xField'].compareTo(b['xField']));

  // Parse data into FlSpot format
  final flSpots = data.map((item) {
    final xValue = item['xField'].toDouble();
    final yValue = item['yField'].toDouble();
    return FlSpot(xValue, yValue);
  }).toList();

  return flSpots;
}

Future<List<FlSpot>> convertDataToFlSpots() async {
  List<FlSpot> data = [];
  List<String> xValues = await FirebaseDataFetcher().fetchXValues(0);
  List<String> yValues = await FirebaseDataFetcher().fetchYValues(0);

  for (int i = 0; i < xValues.length; i++) {
    // Parse x and y values from strings (assuming they are numerical)
    double x = double.parse(xValues[i]);
    double y = double.parse(yValues[i]);

    // Create a new FlSpot instance with parsed values
    data.add(FlSpot(x, y));
  }
  print('returning data');
  return data;
}
