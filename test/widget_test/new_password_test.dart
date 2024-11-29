import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plate/UI/new_password.dart';

void main() {
  testWidgets('NewPasswordScreen has a title and two password fields', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(const MaterialApp(
      home: NewPasswordScreen(),
    ));

    // Verify if the title is present
    expect(find.text('New Password'), findsOneWidget);

    // Verify if the description text is present
    expect(find.text('Please enter your new password below.'), findsOneWidget);

    // Verify if the password fields are present
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verify the "Confirm" button is present
    expect(find.widgetWithText(MaterialButton, 'Confirm'), findsOneWidget);
  });

  testWidgets('Test password fields input', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(const MaterialApp(
      home: NewPasswordScreen(),
    ));

    // Find the password field and enter text
    final passwordField = find.byType(TextFormField).first;
    await tester.enterText(passwordField, 'NewPassword123');

    // Find the confirm password field and enter text
    final confirmPasswordField = find.byType(TextFormField).last;
    await tester.enterText(confirmPasswordField, 'NewPassword123');

    // Trigger a frame
    await tester.pump();

    // Verify if the entered text appears in the fields
    expect(find.text('NewPassword123'), findsNWidgets(2));
  });

  testWidgets('Test the Confirm button click', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(const MaterialApp(
      home: NewPasswordScreen(),
    ));

    // Find the confirm button and tap it
    final confirmButton = find.widgetWithText(MaterialButton, 'Confirm');
    await tester.tap(confirmButton);

    // Trigger a frame
    await tester.pump();

    // Add checks here to ensure correct behavior after button click, for example:
    // expect(find.text('Next Screen'), findsOneWidget); // If you navigate after clicking
  });

  testWidgets('Test "Remember your password?" link', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(const MaterialApp(
      home: NewPasswordScreen(),
    ));

    // Find the link text
    final rememberPasswordLink = find.text('Login');

    // Verify if the link is present
    expect(rememberPasswordLink, findsOneWidget);

    // Tap on the link
    await tester.tap(rememberPasswordLink);

    // Trigger a frame
    await tester.pump();

    // Add verification for navigation here if needed
    // expect(find.byType(LoginScreen), findsOneWidget); // If your link navigates to a LoginScreen
  });
}
