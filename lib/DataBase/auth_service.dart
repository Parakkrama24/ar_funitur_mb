import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user with email and password
  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add additional user details to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'homeNumber': homeNumber,
        'landmark': landmark,
        'lane': lane,
        'dob': dob,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null; // Null indicates success
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  // Login user
  Future<String?> loginUser({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Null indicates success
    } catch (e) {
      return e.toString(); // Return error message
    }
  }
}
