import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jr_design_app/pages/dev_settings/DeveloperMode.dart';
import '../../components/background_gradient_container.dart';
import '../../pages/dev_settings/settings_page.dart';
import 'package:jr_design_app/components/data_box.dart';
import 'rpm_page.dart';
import 'psi_page.dart';
import 'battery_page.dart';
import 'gpm_page.dart';

typedef OnDataBoxPressedCallback = void Function(BuildContext context);

// HomePage widget now includes the gradient and data boxes
class HomePageWidget extends StatelessWidget {
  final String bloodPressure;
  final String bpm;
  final String flowRate;
  final String powerConsumption;

  const HomePageWidget({
    Key? key,
    required this.bloodPressure,
    required this.bpm,
    required this.flowRate,
    required this.powerConsumption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Padding(
      //     padding: const EdgeInsets.only(top: 20.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const SizedBox(width: 86.0),
      //         Image.asset('assets/images/logo.png', height: 50.0),
      //         const SizedBox(width: 5.0),
      //         const Text('Affinity', style: TextStyle(fontSize: 30.0)),
      //       ],
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 30.0),
      //       child: IconButton(
      //         icon: const Icon(Icons.account_circle),
      //         iconSize: 50.0,
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const SettingsPage()),
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          const BackgroundGradientContainer(child: SizedBox.expand()),
          SafeArea(
            child: Center(
              child: Padding(
                //defines the space between the top of the screen and the logo/text
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center row content horizontally
                        children: [
                          const SizedBox(width: 75.0),
                          Image.asset('assets/images/logo.png', height: 50.0),
                          const SizedBox(width: 5.0),
                          const Text('Affinity',
                              style: TextStyle(fontSize: 30.0)),
                          const SizedBox(
                              width:
                                  30.0), // Adjust this width to control the space between text and logo
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
                    // Your DataBox widgets here
                    DataBox(
                      label: 'Blood Pressure',
                      value: bloodPressure + ' mmHg',
                      iconPath: 'assets/images/Blood.png',
                      onPressed: (context) {
                        Navigator.pushNamed(context, '/PSIpage');
                      },
                    ),
                    DataBox(
                      label: 'Heart Rate',
                      value: bpm + ' RPM',
                      iconPath: 'assets/images/Heart.png',
                      onPressed: (context) {
                        Navigator.pushNamed(context, '/RPMpage');
                      },
                    ),
                    DataBox(
                      label: 'Flow Rate',
                      value: flowRate + ' L/min',
                      iconPath: 'assets/images/Flow.png',
                      onPressed: (context) {
                        Navigator.pushNamed(context, '/GPMpage');
                      },
                    ),
                    DataBox(
                      label: 'Power Consumption',
                      value: powerConsumption + ' watts',
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
  String bloodPressure = '0';
  String bpm = '0';
  String flowRate = '0';
  String powerConsumption = '0';

  int pageIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      HomePageWidget(
        bloodPressure: bloodPressure,
        bpm: bpm,
        flowRate: flowRate,
        powerConsumption: powerConsumption,
      ),
      const SettingsPage(),
      const DeveloperMode(),
    ];

    // Initialize listeners
    _initBloodPressureListener();
    _initHeartRateListener();
    _initFlowRateListener();
    _initPowerConsumptionListener();
  }

  // Your _initBloodPressureListener, _initHeartRateListener,
  // _initFlowRateListener, and _initPowerConsumptionListener methods here
  void _initBloodPressureListener() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('blood_pressure')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data =
            (snapshot.data() as Map<String, dynamic>)?['data'];
        if (data != null) {
          setState(() {
            bloodPressure = data['y_value']
                .toString(); // Update y_value with blood pressure
          });
        } else {
          setState(() {
            bloodPressure = 'Unknown'; // Set to 'Unknown' if data is null
          });
        }
      }
    });
  }

  void _initHeartRateListener() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('bpm')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data =
            (snapshot.data() as Map<String, dynamic>)?['data'];
        if (data != null) {
          setState(() {
            bpm = data['y_value']
                .toString(); // Update blood pressure state variable
          });
        } else {
          setState(() {
            bpm = 'Unknown'; // Set to 'Unknown' if mmHg is null
          });
        }
      }
    });
  }

  void _initFlowRateListener() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('flow_rate')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data =
            (snapshot.data() as Map<String, dynamic>)?['data'];
        if (data != null) {
          setState(() {
            flowRate = data['y_value']
                .toString(); // Update blood pressure state variable
          });
        } else {
          setState(() {
            flowRate = 'Unknown'; // Set to 'Unknown' if mmHg is null
          });
        }
      }
    });
  }

  void _initPowerConsumptionListener() {
    FirebaseFirestore.instance
        .collection('sensor_data')
        .doc('power_consumption')
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data =
            (snapshot.data() as Map<String, dynamic>)?['data'];
        if (data != null) {
          setState(() {
            powerConsumption = data['y_value']
                .toString(); // Update blood pressure state variable
          });
        } else {
          setState(() {
            powerConsumption = 'Unknown'; // Set to 'Unknown' if mmHg is null
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: pages[pageIndex], // Updated to show the current page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (int index) {
          setState(() {
            pageIndex = index;
            // Update the pages list if the HomePage is selected to reflect any state changes
            if (pageIndex == 0) {
              pages[0] = HomePageWidget(
                bloodPressure: bloodPressure,
                bpm: bpm,
                flowRate: flowRate,
                powerConsumption: powerConsumption,
              );
            }
          });
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
