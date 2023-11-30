import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authstatechanges => _firebaseAuth.authStateChanges();

  Future<void> get userData => getUserInfo();

  Future<Map<String, dynamic>?> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      return userData.data();
    }
  }



  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> deleteUserAndFirestoreData() async {
    try {
      // Delete the user account from Firebase Authentication
      await currentUser?.delete();

      // Delete the corresponding data from Firestore
      await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).delete();
    } on FirebaseAuthException catch (e) {
      // Handle the exception if needed
      print('Error deleting user account: ${e.message}');
    }
  }
}
