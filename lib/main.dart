import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'donor_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/donor_home': (context) => DonorHomePage(),  // Add this route
      },
    );
  }
}