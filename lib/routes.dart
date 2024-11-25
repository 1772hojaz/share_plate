import 'package:get/get.dart';
import 'verification_page.dart';
import 'confirmation_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/verification', page: () => VerificationPage()),
    GetPage(name: '/confirmation', page: () => ConfirmationPage()),
  ];
}

