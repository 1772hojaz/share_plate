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
    return GetMaterialApp(
      title: "Share Plate",
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/home", page: () => FoodListingPage())
      ],
      debugShowCheckedModeBanner: false,
      home: Terms(),
    );
  }
}
