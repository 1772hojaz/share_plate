import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plate/UI/signup.dart';

void main() {
  testWidgets('SignUpScreen renders correctly', (WidgetTester tester) async {
    // Build the SignUpScreen widget
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

    // Verify that the SignUpScreen title is present
    expect(find.text('Sign Up'), findsOneWidget);

    // Verify that the text fields are present
    expect(find.byType(TextField), findsNWidgets(4)); // 4 text fields (Name, Email, Location, Password)

    // Verify that the "SIGN UP" button is present
    expect(find.text('SIGN UP'), findsOneWidget);

    // Verify that the "Have an account? SIGN IN" link is present
    expect(find.text('Have an account? SIGN IN'), findsOneWidget);
  });

  testWidgets('Email and Password input validation', (WidgetTester tester) async {
    // Build the SignUpScreen widget
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

    // Find the text fields
    find.byType(TextField).at(0); // Name field
    final emailField = find.byType(TextField).at(1); // Email field
    final passwordField = find.byType(TextField).at(3); // Password field

    // Enter invalid email and password
    await tester.enterText(emailField, 'invalid-email');
    await tester.enterText(passwordField, '123');
    await tester.pump(); // Trigger a frame

    // Verify that the email is invalid (you can customize this check if you add validation to the fields)
    expect(find.text('invalid-email'), findsOneWidget);
    expect(find.text('123'), findsOneWidget);

    // Try to sign up (sign-up button should be disabled)
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(ElevatedButton).evaluate().single.widget.enabled, isFalse);

    // Now enter a valid email and password
    await tester.enterText(emailField, 'valid.email@example.com');
    await tester.enterText(passwordField, 'ValidPassword123');
    await tester.pump();

    // Verify that the sign-up button is enabled now
    expect(find.byType(ElevatedButton).evaluate().single.widget.enabled, isTrue);
  });

  testWidgets('Check if Terms and Policy are clickable', (WidgetTester tester) async {
    // Build the SignUpScreen widget
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

    // Tap on the "terms & policy" link
    final termsAndPolicyLink = find.text('terms & policy');
    await tester.tap(termsAndPolicyLink);
    await tester.pump(); // Trigger a frame

    // Verify that the terms and policy dialog is shown
    expect(find.text('Terms and Policy'), findsOneWidget);
    expect(find.text('Here you can display your terms and policy.'), findsOneWidget);

    // Close the dialog
    final closeButton = find.text('Close');
    await tester.tap(closeButton);
    await tester.pump(); // Trigger a frame

    // Verify that the dialog has been closed
    expect(find.text('Terms and Policy'), findsNothing);
  });

  testWidgets('Sign up button functionality', (WidgetTester tester) async {
    // Build the SignUpScreen widget
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));

    // Find the sign-up button
    final signUpButton = find.text('SIGN UP');

    // Initially, the sign-up button should be disabled (because email and password are empty)
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(ElevatedButton).evaluate().single.widget.enabled, isFalse);

    // Enter text in the email and password fields
    await tester.enterText(find.byType(TextField).at(1), 'test@example.com'); // Email
    await tester.enterText(find.byType(TextField).at(3), 'password123'); // Password
    await tester.pump();

    // The sign-up button should now be enabled
    expect(find.byType(ElevatedButton).evaluate().single.widget.enabled, isTrue);

    // Tap the sign-up button
    await tester.tap(signUpButton);
    await tester.pump(); // Trigger a frame

    // Check if the sign-up action was triggered (for now, you can test a simple print statement or call your function)
    // If Firebase integration works, you could test the sign-up method's response.
    // For now, print a message to confirm the button was tapped
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}

extension on Widget {
   get enabled => null;
}
