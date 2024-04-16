import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HeartDataPage extends StatefulWidget {
  @override
  _HeartDataPageState createState() => _HeartDataPageState();
}

class _HeartDataPageState extends State<HeartDataPage> {
  final TextEditingController _usernameController = TextEditingController();
  final UserRepository _userRepository = UserRepository();
  String _email = '';
  String _password = '';

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
        _email = userData['email'] ?? '';
        _password = userData['password'] ?? '';
      });
    }
  }

  Future<void> _saveUsername() async {
    await _userRepository.updateUsername(_usernameController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Username updated successfully!')),
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
            SizedBox(height: 20),
            Text("Email: $_email"),
            // SizedBox(height: 10),
            // Text("Password: $_password"),  // Consider removing this for security reasons
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUsername,
              child: Text('Save Username'),
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

  Future<void> updateUsername(String username) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'username': username
      });
    }
  }
}