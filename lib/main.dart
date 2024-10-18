import 'package:flutter/material.dart';
import 'package:share_plate/UI/food_listing.dart'; // Import the food listing page
import 'package:share_plate/UI/new_password.dart'; // Import the new password page if needed

void main() {
  runApp(const MyApp()); // Run the MyApp widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: FoodListingPage(), // Set the FoodListingPage as the home screen
    );
  }
}
