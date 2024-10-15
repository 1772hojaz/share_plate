import "package:flutter/material.dart";
import 'signup.dart'; // Importing the signup screen

void main() {
  runApp(const SignUpApp());
}

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(), // Setting the home screen as the SignUpScreen
    );
  }
}
