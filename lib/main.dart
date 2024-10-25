import 'package:flutter/material.dart';
import 'home_page.dart'; // Import the HomePage
import 'search_screen.dart'; // Import the SearchScreen

void main() {
  runApp(const SharePlateApp());
}

class SharePlateApp extends StatelessWidget {
  const SharePlateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SharePlate Rwanda',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(), // Set the home page
    );
  }
}
