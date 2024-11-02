
import 'package:share_plate/UI/feedback_page.dart';
import 'package:get/get.dart';
import 'UI/food_listing.dart';
import 'splash_screen.dart';
import 'UI/signin_page.dart';
import 'UI/terms.dart';
import 'UI/fogot_password.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 

    return GetMaterialApp(
      title: "Share Plate",
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/home", page: () => FoodListingPage()),
        GetPage(name: '/signin', page: () => SignInPage()),
        GetPage(name: '/signin', page: () => SignInPage()),
        GetPage(name: '/fogotpassword', page: () => ForgotPasswordScreen())
      ],
      debugShowCheckedModeBanner: false,


    );
  }
}
