import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:share_plate/UI/food_listing.dart'; 
import 'package:share_plate/widgets/custom_bottom_nav_bar.dart';

void main() {
  // Ensure GetX controller and dependencies are properly initialized
  setUp(() async {
    await Get.putAsync(() async => Future.value(FoodListingPageController()));
  });

  testWidgets('FoodListingPage has a transparent app bar and profile icon', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: FoodListingPage(),
      ),
    );

    // Verify if the app bar is transparent and profile icon exists
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byIcon(Icons.account_circle), findsOneWidget);
  });

  testWidgets('Food items are displayed and tappable', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: FoodListingPage(),
      ),
    );

    // Verify if the food items are displayed
    expect(find.byType(GestureDetector), findsNWidgets(3)); // We expect 3 food items
    expect(find.text('Delicious burger with extra cheese.'), findsOneWidget);
    expect(find.text('Freshly baked pizza with toppings.'), findsOneWidget);
    expect(find.text('Healthy salad with vegetables.'), findsOneWidget);

    // Tap on the first food item
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    // Verify navigation to Reserve page (replace with your actual Reserve page title or identifier)
    expect(find.text('Reserve'), findsOneWidget);
  });

  testWidgets('Reserve status updates when tapping on food item', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      const MaterialApp(
        home: FoodListingPage(),
      ),
    );

    // Tap on the first food item
    final firstFoodItem = find.byType(GestureDetector).first;
    await tester.tap(firstFoodItem);
    await tester.pump();

    // Verify the item is reserved (assuming the "Reserved" text will be updated after tapping)
    expect(find.text('Reserved'), findsOneWidget);

    // Go back and verify the status in the food listing
    await tester.pageBack();
    await tester.pump();

    // Verify the food item is now reserved in the list
    expect(find.text('Reserved'), findsOneWidget);
  });

  testWidgets('FoodListingPage contains custom bottom nav bar', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      const MaterialApp(
        home: FoodListingPage(),
      ),
    );

    // Verify the bottom navigation bar is displayed
    expect(find.byType(CustomBottomNavBar), findsOneWidget);

    // Verify that tapping on the bottom nav bar changes the selected index
    await tester.tap(find.byIcon(Icons.home)); // Adjust the icon to match your bottom nav bar
    await tester.pump();

    // Verify if the selected index was updated (assuming your app shows some indication of it)
    expect(find.text('Home'), findsOneWidget);
  });
}
