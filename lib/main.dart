import 'package:flutter/material.dart';

import 'UI/home_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // Ensure this file is generated using Firebase CLI or FlutterFire CLI
// import 'UI/home_page.dart'; // Import the HomePage widget file

void main() async {
  // Ensure widget binding is initialized before Firebase initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // await Firebase.initializeApp(
   // options: DefaultFirebaseOptions.currentPlatform,
 // );

  // Run the app
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
      home: HomePage(), // Set HomePage as the initial screen
    );
  }
}
