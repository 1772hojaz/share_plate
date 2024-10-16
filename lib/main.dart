import 'package:flutter/material.dart';
import 'package:share_plate/UI/new_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NewPasswordScreen(), 
    );
  }
}
