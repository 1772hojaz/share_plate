import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plate/UI/feedback_page.dart';
import 'UI/food_listing.dart';
import 'UI/splash_screen.dart';
import 'UI/signin_page.dart';
import 'UI/terms.dart';
import 'UI/fogot_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'UI/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Share Plate',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => FoodListingPage()),
        GetPage(name: '/signin', page: () => SignInScreen()),
        GetPage(name: '/signup', page: () => SignUpScreen()),
        GetPage(
            name: '/forgotpassword', page: () => ForgotPasswordScreen()),
        GetPage(name: '/feedback', page: () => const FeedbackPage()),
        GetPage(name: '/terms', page: () => TermsPage()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
