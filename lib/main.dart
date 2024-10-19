<<<<<<< HEAD
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
=======
import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage

void main() {
  runApp(SharePlateApp());
}

class SharePlateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SharePlate Rwanda',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(), // Set the home page
>>>>>>> 565aaa4 (home page's commit)
    );
  }
}
