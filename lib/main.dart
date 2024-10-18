import 'package:flutter/material.dart';
// import 'package:share_plate/UI/fogot_password.dart';
// import 'package:share_plate/UI/signin_page.dart';
import 'package:share_plate/UI/terms.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Terms(),
    );
  }
}
