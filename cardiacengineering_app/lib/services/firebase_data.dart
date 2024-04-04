import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseDataFetcher extends StatelessWidget {
  final List<String> sessionNames = [
    "session 03-28-24 12:04",
    "session 03-28-24 12:13",
  ];

  FirebaseDataFetcher({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: Implement build method
    throw UnimplementedError();
  }

  // Separate methods for fetching xValues and yValues
  Future<List<String>> fetchXValues(int selectedSessionIndex) async {
    List<String> xValues = [];
    final snapshot = await FirebaseFirestore.instance
            .collection('large_heart_data')
            .doc('bpm') // Assuming xValues are fetched from the same document as yValues
            .collection(sessionNames[selectedSessionIndex])
            .doc('data')
            .get();

        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          final dataArray = data['data'] as List<dynamic>;

          for (final map in dataArray) {
            xValues.add(map['x_value'] as String); // Extracting only xValues
          }
        } else {
          print('Document not found');
        }    
    print('returning xValues');

    return xValues;
  }

  Future<List<String>> fetchYValues(int selectedSessionIndex) async {
    List<String> yValues = [];
    final snapshot = await FirebaseFirestore.instance
        .collection('large_heart_data')
        .doc('bpm')
        .collection(sessionNames[selectedSessionIndex])
        .doc('data')
        .get();

    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final dataArray = data['data'] as List<dynamic>;

      for (final map in dataArray) {
        yValues.add(map['y_value'] as String); // Extracting only yValues
      }
    } else {
      print('Document not found');
    }
    // ... (your data fetching code for yValues)
    print('returning yValues');

    return yValues;
  }
}