import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/background_gradient_container.dart';
import '../../pages/dev_settings/settings_page.dart';
import 'package:jr_design_app/components/data_box.dart';
import 'rpm_page.dart';
import 'psi_page.dart';
import 'battery_page.dart';
import 'gpm_page.dart';
import 'record_now_page.dart';
import '../../components/background_gradient_container.dart';
import '../../pages/dev_settings/settings_page.dart';

typedef OnDataBoxPressedCallback = void Function(BuildContext context);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String blood_pressure = '0'; // Initialize blood pressure with '0'
  String bpm = '0'; // Initialize heart rate with '0'
  String flow_rate = '0'; // Initialize flow rate with '0'
  String power_consumption = '0'; // Initialize power consumption with '0'

  @override
  void initState() {
    super.initState();
    _initBloodPressureListener(); // Call function to listen for blood pressure changes
    _initHeartRateListener(); // Call function to listen for heart rate changes'
    _initFlowRateListener(); // Call function to listen for flow rate changes
    _initPowerConsumptionListener(); // Call function to listen for power consumption changes
  }

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
            blood_pressure = data['y_value']
                .toString(); // Update y_value with blood pressure
          });
        } else {
          setState(() {
            blood_pressure = 'Unknown'; // Set to 'Unknown' if data is null
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
            flow_rate = data['y_value']
                .toString(); // Update blood pressure state variable
          });
        } else {
          setState(() {
            flow_rate = 'Unknown'; // Set to 'Unknown' if mmHg is null
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
            power_consumption = data['y_value']
                .toString(); // Update blood pressure state variable
          });
        } else {
          setState(() {
            power_consumption = 'Unknown'; // Set to 'Unknown' if mmHg is null
          });
        }
      }
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 86.0),
            Image.asset(
              'assets/images/logo.png',
              height: 50.0,
            ),
            const SizedBox(width: 5.0),
            const Text(
              'Affinity',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: IconButton(
              icon: const Icon(Icons.account_circle),
              iconSize: 50.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: BackgroundGradientContainer(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).padding.top +
                      kToolbarHeight +
                      20), // Added space
              _buildDataBox(
                context,
                label: "Blood Pressure",
                value: blood_pressure + ' mmHg',
                iconPath: 'assets/images/Blood.png',
                iconSize: 50.0,
                labelFontSize: 20.0,
                valueFontSize: 20.0,
                borderRadius: 20.0,
                onPressed: (context) {
                  Navigator.pushNamed(context, '/PSIpage');
                },
              ),
              _buildDataBox(
                context,
                label: 'Heart Rate',
                value: bpm + ' BPM',
                iconPath: 'assets/images/Heart.png',
                iconSize: 50.0,
                labelFontSize: 20.0,
                valueFontSize: 20.0,
                borderRadius: 20.0,
                onPressed: (context) {
                  Navigator.pushNamed(context, '/RPMpage');
                },
              ),
              _buildDataBox(
                context,
                label: 'Flow Rate',
                value: flow_rate + ' L/min',
                iconPath: 'assets/images/Flow.png',
                iconSize: 50.0,
                labelFontSize: 20.0,
                valueFontSize: 20.0,
                borderRadius: 20.0,
                onPressed: (context) {
                  Navigator.pushNamed(context, '/GPMpage');
                },
              ),
              _buildDataBox(
                context,
                label: 'Power Consumption',
                value: power_consumption + ' watts',
                iconPath: 'assets/images/Battery.png',
                iconSize: 50.0,
                labelFontSize: 20.0,
                valueFontSize: 20.0,
                borderRadius: 20.0,
                onPressed: (context) {
                  Navigator.pushNamed(context, '/BatteryPage');
                },
              ),
              _buildDataBox(
                context,
                label: 'Record Now',
                value: '',
                iconPath: 'assets/images/logo.png',
                iconSize: 50.0,
                labelFontSize: 20.0,
                valueFontSize: 0,
                borderRadius: 20.0,
                onPressed: (context) {
                  Navigator.pushNamed(context, '/RecordNow');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataBox(
    BuildContext context, {
    required String label,
    required String value,
    required String iconPath,
    required double iconSize,
    required double labelFontSize,
    required double valueFontSize,
    required double borderRadius,
    required OnDataBoxPressedCallback onPressed,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: GestureDetector(
        onTap: () {
          onPressed(context);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Adjusted to center
            children: [
              Image.asset(
                iconPath,
                height: iconSize,
                width: iconSize,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Adjusted to center
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: labelFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Adjusted to center
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: valueFontSize,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 86, 140, 234),
                      ),
                      textAlign: TextAlign.center, // Adjusted to center
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.add,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
