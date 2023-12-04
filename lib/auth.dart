import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

User? get currentUser => _firebaseAuth.currentUser;

Stream<User?> get authstatechanges => _firebaseAuth.authStateChanges();

Future<void> get userData => getUserInfo();

Future<Map<String, dynamic>?> getUserInfo() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .get();
    return userData.data();
  }
}

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();

    // Show a success toast message
    Fluttertoast.showToast(
      msg: "Sign Out Successful!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } catch (e) {
    print("Failed to sign out: $e");

    // Show an error toast message
    Fluttertoast.showToast(
      msg: "Failed to Sign Out: $e",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

Future<void> deleteUserAndFirestoreData() async {
  try {
    // Delete the user account from Firebase Authentication
    await currentUser?.delete();

    // Delete the corresponding data from Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .delete();
  } on FirebaseAuthException catch (e) {
    // Handle the exception if needed
    print('Error deleting user account: ${e.message}');
  }
}
