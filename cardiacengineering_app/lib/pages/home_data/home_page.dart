import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/background_gradient_container.dart';
import 'package:jr_design_app/components/data_box.dart';
import '../../pages/dev_settings/settings_page.dart';
import '../../pages/dev_settings/DeveloperMode.dart';

// HomePage widget now includes the gradient and data boxes and is a StatefulWidget
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  String bloodPressure = '0';
  String bpm = '0';
  String flowRate = '0';
  String powerConsumption = '0';

  @override
  void initState() {
    super.initState();
    _initListeners();
  }

  void _initListeners() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('blood_pressure')
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.data()?['data'];
      setState(() => bloodPressure = data?['y_value'].toString() ?? 'Unknown');
    });

    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('bpm')
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.data()?['data'];
      setState(() => bpm = data?['y_value'].toString() ?? 'Unknown');
    });

    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('flow_rate')
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.data()?['data'];
      setState(() => flowRate = data?['y_value'].toString() ?? 'Unknown');
    });

    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('power_consumption')
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.data()?['data'];
      setState(
          () => powerConsumption = data?['y_value'].toString() ?? 'Unknown');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradientContainer(child: SizedBox.expand()),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
// Header Row with Logo and Settings Icon
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // This centers the Row content
                        children: [
                          // Expanded widget to ensure the text and logo take up all available space
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Centers the text and logo within the Expanded widget
                            children: [
                              Image.asset('assets/images/logo.png',
                                  height: 50.0),
                              const SizedBox(width: 5.0),
                              const Text('Affinity',
                                  style: TextStyle(fontSize: 30.0)),
                            ],
                          ),

                          //IconButton is outside the Expanded widget, so it aligns to the right
                          IconButton(
                            icon: const Icon(Icons.account_circle),
                            iconSize: 50.0,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SettingsPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                        height:
                            40), // Space between the row and the first DataBox
                    // Dynamic DataBox widgets for displaying sensor data
                    DataBox(
                      label: 'Blood Pressure',
                      value: '$bloodPressure mmHg',
                      iconPath: 'assets/images/Blood.png',
                      onPressed: (context) {
                        Navigator.pushNamed(context, '/PSIpage');
                      },
                    ),
                    DataBox(
                      label: 'Heart Rate',
                      value: '$bpm BPM',
                      iconPath: 'assets/images/Heart.png',
                      onPressed: (context) {
                        Navigator.pushNamed(context, '/RPMpage');
                      },
                    ),
                    DataBox(
                      label: 'Flow Rate',
                      value: '$flowRate L/min',
                      iconPath: 'assets/images/Flow.png',
                      onPressed: (context) {
                        Navigator.pushNamed(context, '/GPMpage');
                      },
                    ),
                    DataBox(
                      label: 'Power Consumption',
                      value: '$powerConsumption watts',
                      iconPath: 'assets/images/Battery.png',
                      onPressed: (context) {
                        Navigator.pushNamed(context, '/BatteryPage');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final pages = [
    const HomePageWidget(),
    const SettingsPage(),
    const DeveloperMode()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (int index) {
          setState(() => pageIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.developer_mode), label: "Developer Mode"),
        ],
      ),
    );
  }
}
