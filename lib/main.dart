import "package:flutter/material.dart";
import 'signup.dart';  // Importing the signup screen

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),  // Setting the home screen as the SignUpScreen
    );
  }
}
