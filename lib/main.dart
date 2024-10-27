import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'UI/food_listing.dart';
import 'splash_screen.dart';
import 'donor_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: "Share Plate",
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/home", page: () => FoodListingPage())
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

