import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:share_plate/UI/user_profile_page.dart';

void main() {
  // Create a mock controller to test state management
  late UserProfileController controller;

  // Set up the controller before each test
  setUp(() {
    controller = UserProfileController();
    // Initialize the GetX dependency
    Get.put(controller);
  });

  // Test 1: Test if the UserProfilePage is built correctly
  testWidgets('UserProfilePage renders with correct data', (WidgetTester tester) async {
    // Arrange: Pump the UserProfilePage widget into the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: UserProfilePage(),
      ),
    );

    // Act: Find widgets by key or type and check if they render the correct data
    expect(find.text('John D'), findsOneWidget); // User name should appear
    expect(find.text('john.d@example.com'), findsOneWidget); // User email should appear
    expect(find.text('Kigali, Rwanda'), findsOneWidget); // User address should appear
    expect(find.text('Fresh Apples - 5 kg'), findsOneWidget); // First past food request should appear
    expect(find.text('Assorted Vegetables - 3 kg'), findsOneWidget); // Second past food request should appear

    // Check if the "Change Profile Picture" button is displayed
    expect(find.text('Change Profile Picture'), findsOneWidget);
  });

  // Test 2: Test if the profile picture placeholder is shown when no image is set
  testWidgets('Profile picture shows default image when no profile picture is set', (WidgetTester tester) async {
    // Arrange: Pump the UserProfilePage widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserProfilePage(),
      ),
    );

    // Act: Find the profile picture container
    final profileImage = find.byType(CircleAvatar);

    // Assert: Ensure the profile picture shows the default asset image
    expect(profileImage, findsOneWidget);
  });

  // Test 3: Test if changing the user name updates the UI
  testWidgets('User name is updated when controller changes value', (WidgetTester tester) async {
    // Arrange: Pump the UserProfilePage widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserProfilePage(),
      ),
    );

    // Act: Change the user name via the controller
    controller.userName.value = 'Jane D';

    // Wait for the state to update
    await tester.pump();

    // Assert: Ensure the UI updates with the new name
    expect(find.text('Jane D'), findsOneWidget);
  });

  // Test 4: Test if notifications are toggled correctly
  testWidgets('Email notifications checkbox toggles correctly', (WidgetTester tester) async {
    // Arrange: Pump the UserProfilePage widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserProfilePage(),
      ),
    );

    // Act: Find and tap the checkbox for email notifications
    final emailNotificationCheckbox = find.byWidgetPredicate((widget) =>
        widget is Checkbox && widget.value == false);
    await tester.tap(emailNotificationCheckbox);
    await tester.pump();

    // Assert: Ensure the checkbox is checked after tapping
    expect(controller.emailNotifications.value, true);

    // Act: Uncheck the checkbox again
    await tester.tap(emailNotificationCheckbox);
    await tester.pump();

    // Assert: Ensure the checkbox is unchecked after tapping again
    expect(controller.emailNotifications.value, false);
  });

  // Test 5: Test if the logout dialog opens when the logout button is pressed
  testWidgets('Logout dialog appears when logout button is pressed', (WidgetTester tester) async {
    // Arrange: Pump the UserProfilePage widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserProfilePage(),
      ),
    );

    // Act: Find and tap the "Log Out" button
    final logoutButton = find.text('Log Out');
    await tester.tap(logoutButton);
    await tester.pump();

    // Assert: Ensure the dialog appears
    expect(find.text('Logout'), findsOneWidget);
    expect(find.text('Are you sure you want to logout?'), findsOneWidget);
  });

  // Test 6: Test if the app properly shows the initial email notification value (false)
  testWidgets('Email notifications checkbox has correct initial value', (WidgetTester tester) async {
    // Arrange: Pump the UserProfilePage widget
    await tester.pumpWidget(
      MaterialApp(
        home: UserProfilePage(),
      ),
    );

    // Act: Find the email notifications checkbox
    final checkbox = find.byWidgetPredicate((widget) =>
        widget is Checkbox && widget.value == false);

    // Assert: Ensure the checkbox is initially unchecked
    expect(checkbox, findsOneWidget);
  });
}
