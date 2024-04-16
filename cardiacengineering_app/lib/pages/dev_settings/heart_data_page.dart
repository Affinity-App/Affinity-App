import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HeartDataPage extends StatefulWidget {
  @override
  _HeartDataPageState createState() => _HeartDataPageState();
}

class _HeartDataPageState extends State<HeartDataPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _heartIdController = TextEditingController();
  final UserRepository _userRepository = UserRepository();
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic>? userData = await _userRepository.fetchUserData();
    if (userData != null) {
      setState(() {
        _usernameController.text = userData['username'] ?? '';
        _heartIdController.text = userData['heartId'] ?? '';
        _email = userData['email'] ?? '';
      });
    }
  }

  Future<void> _saveChanges() async {
    await _userRepository.updateUserData(_usernameController.text, _heartIdController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Updates saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heart ID"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _heartIdController,
              decoration: InputDecoration(labelText: 'Heart ID'),
            ),
            SizedBox(height: 20),
            Text("Email: $_email"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      return userDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  Future<void> updateUserData(String username, String heartId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'username': username,
        'heartId': heartId
      });
    }
  }
}