import 'package:flutter/material.dart';
import 'package:share_plate/UI/food_listing.dart';
import 'package:share_plate/UI/transaction_completion.dart';
void main() {
  runApp(const MyApp()); // Run the MyApp widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: TransactionCompletionPage(), // Set the FoodListingPage as the home screen
    );
  }
}
