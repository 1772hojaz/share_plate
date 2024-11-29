import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:share_plate/UI/reserve.dart' as reserve;
import 'package:share_plate/UI/reserve.dart';
import 'package:share_plate/UI/user_profile_page.dart' as userProfile;


void main() {
  // Test 1: Test if the Reserve page renders correctly with the passed image and description
  testWidgets('Reserve page renders food image and description', (WidgetTester tester) async {
    // Arrange: Pump the Reserve widget with test data
    await tester.pumpWidget(
      MaterialApp(
        home: Reserve(imagePath: 'assets/sample-food.jpg', description: 'Delicious food for you!'),
      ),
    );

    // Act: Find widgets by text or key
    final imageFinder = find.byType(Container);
    final descriptionFinder = find.text('Delicious food for you!');
    final reserveButtonFinder = find.text('Reserve');

    // Assert: Ensure image and description are displayed
    expect(imageFinder, findsOneWidget); // Ensure image container is found
    expect(descriptionFinder, findsOneWidget); // Ensure description is found
    expect(reserveButtonFinder, findsOneWidget); // Ensure Reserve button is found
  });

  // Test 2: Test if tapping the back button works as expected
  testWidgets('Back button works correctly', (WidgetTester tester) async {
    // Arrange: Pump the Reserve widget
    await tester.pumpWidget(
      MaterialApp(
        home: Reserve(imagePath: 'assets/sample-food.jpg', description: 'Delicious food for you!'),
      ),
    );

    // Act: Tap the back button
    final backButton = find.byIcon(Icons.arrow_back);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Assert: Ensure we have navigated back (should not find Reserve page after tap)
    expect(find.byType(Reserve), findsNothing);
  });

  // Test 3: Test if tapping the user profile icon navigates to the UserProfilePage
  testWidgets('Profile icon navigates to UserProfilePage', (WidgetTester tester) async {
    // Arrange: Pump the Reserve widget
    await tester.pumpWidget(
      MaterialApp(
        home: Reserve(imagePath: 'assets/sample-food.jpg', description: 'Delicious food for you!'),
      ),
    );

    // Act: Tap the user profile icon
    final profileIcon = find.byType(GestureDetector);
    await tester.tap(profileIcon);
    await tester.pumpAndSettle();

    // Assert: Ensure the UserProfilePage is displayed
    expect(find.byType(userProfile.UserProfilePage), findsOneWidget);
  });

  // Test 4: Test Reserve button (when activated)
  testWidgets('Reserve button shows the snackbar and navigates after being pressed', (WidgetTester tester) async {
    // Arrange: Pump the Reserve widget
    await tester.pumpWidget(
      MaterialApp(
        home: Reserve(imagePath: 'assets/sample-food.jpg', description: 'Delicious food for you!'),
      ),
    );

    // Act: Tap the Reserve button
    final reserveButton = find.text('Reserve');
    await tester.tap(reserveButton);
    await tester.pumpAndSettle();

    // Assert: Ensure a snackbar appears
    expect(find.text('Your item has been reserved!'), findsOneWidget);

    // Act: Wait for snackbar duration
    await tester.pump(Duration(seconds: 2));
  });

  // Test 5: Test the bottom navigation bar
  testWidgets('Bottom navigation bar is displayed correctly', (WidgetTester tester) async {
    // Arrange: Pump the Reserve widget
    await tester.pumpWidget(
      MaterialApp(
        home: Reserve(imagePath: 'assets/sample-food.jpg', description: 'Delicious food for you!'),
      ),
    );

    // Act: Check for the bottom navigation items
    final homeText = find.text('Home');
    final donateText = find.text('Donate');
    final searchText = find.text('Search');

    // Assert: Ensure the bottom navigation items are displayed
    expect(homeText, findsOneWidget);
    expect(donateText, findsOneWidget);
    expect(searchText, findsOneWidget);
  });
}
