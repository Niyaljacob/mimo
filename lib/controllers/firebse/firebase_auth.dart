import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimo/model/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user and save user details to Firestore
  Future<void> registerUser(RegisterModel registerModel) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: registerModel.email,
        password: registerModel.password,
      );

      // Save user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': registerModel.fullName,
        'email': registerModel.email,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Sign in user
  Future<User?> signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign out user
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
