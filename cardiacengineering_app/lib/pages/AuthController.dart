import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();

  bool isPhoneNumber(String str) {
    // Define a regular expression pattern for a typical phone number
    RegExp regExp =
        RegExp(r'^\d{10}$'); // Example pattern for a 10-digit phone number

    // Check if the string matches the regular expression pattern
    return regExp.hasMatch(str);
  }

  /*

 	signInWithEmailAndPassword

	Feb 22, 2024

	Wyatt Bodle

	Function designed to log a user in using firebase auth

	Declared Variables:
	None

	Parameters:
	String email: Email passed in for signing in
	String password: Password passed in to attempt a sign in

	*/
  // Modify your signInWithEmailAndPassword method to return an error object if login fails
  Future<dynamic> signInWithEmailAndPassword(
      String email, String password, String username) async {
    print("Logging in with email : ");
    print(email);
    //Login with email
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      storeTokenAndData(username);
      return userCredential.user; // Return user on successful login
    } catch (error) {
      return error; // Return error object on failed login
    }
  }

  // Register with email and password
  Future<dynamic> registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      storeTokenAndData(username);
      return userCredential.user;
    } catch (e) {
      print(e);
      return e;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {}
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await storage.delete(key: "username");
    } catch (e) {}
  }

  //Function to get token
  Future<String?> getToken() async {
    return await storage.read(key: "username");
  }
}

class PhoneNumberVerification {
  final Function(PhoneAuthCredential) verificationCompleted;
  final Function(FirebaseAuthException) verificationFailed;
  final Function(String, int?) codeSent;
  final Function(String) codeAutoRetrievalTimeout;
  final String phoneNumber;

  PhoneNumberVerification({
    required this.verificationCompleted,
    required this.verificationFailed,
    required this.codeSent,
    required this.codeAutoRetrievalTimeout,
    required this.phoneNumber,
  });

  bool isPhoneNumber(String str) {
    // Define a regular expression pattern for a typical phone number
    RegExp regExp =
        RegExp(r'^\d{10}$'); // Example pattern for a 10-digit phone number

    // Check if the string matches the regular expression pattern
    return regExp.hasMatch(str);
  }

  Future<dynamic> signInWithPhoneNumber(String number) async {
    if (!number.contains('@') && isPhoneNumber(number)) {
      try {
        // Access Firestore collection and retrieve document
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('User')
            .doc(number) // Assuming 'email' is the document ID
            .get();

        if (userDoc.exists) {
          // Get the 'email' field from the document and set it to 'email'
          number = userDoc['phone'];
        }
      } catch (error) {}
    }
    //Login with email
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      ); // Return user on successful login
    } catch (error) {
      print(error);
      return error; // Return error object on failed login
    }
  }
}

//Function to store token for login
Future<void> storeTokenAndData(String username) async {
  final storage = const FlutterSecureStorage();
  if (username != null) {
    await storage.write(key: "username", value: username);
  }
  print("Token save attempted");
}
