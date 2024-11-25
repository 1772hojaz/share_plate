import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Verification App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/verification',
      getPages: AppRoutes.routes,
    );
  }
}
