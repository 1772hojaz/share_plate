import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String location,
    required BuildContext context,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's unique ID (uid)
      String uid = userCredential.user!.uid;

      // Save additional user data to Firestore with uid
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'location': location,
        'createdAt': Timestamp.now(),
      });

      // Navigate to the home screen after the data is saved
      Get.offNamed('/'); // This will navigate to the home screen or root screen
    } on FirebaseAuthException catch (e) {
      String message = '';

      // Handle specific Firebase errors
      if (e.code == 'weak-password') {
        message = 'The password you provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account with this email already exists';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid';
      } else {
        message = 'An unexpected error occurred. Please try again later.';
      }

      // Show error message using FlutterToast
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14,
      );
    } catch (e) {
      // Handle any other exceptions
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }
}
