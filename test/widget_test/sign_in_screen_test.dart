import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:share_plate/UI/signin_page.dart';
import 'package:share_plate/services/auth_service.dart';

void main() {
  testWidgets('SignInScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    expect(find.text('Sign In'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Back button navigates to previous screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // back action leads to a previous screen, test accordingly.
    expect(find.byType(SignInScreen), findsNothing); // This test depends on navigation logic.
  });

  testWidgets('SignIn button triggers sign-in', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

  });

  testWidgets('Email and Password fields are empty initially', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    expect(find.byType(TextFormField).at(0), findsOneWidget);
    expect(find.byType(TextFormField).at(1), findsOneWidget);

    // Verify that the email and password fields are empty
    expect(find.text(''), findsNWidgets(2)); // Check that the TextFormFields are empty.
  });

  testWidgets('Forgot Password button navigates correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();

    // Verify navigation to the forgot password screen
    expect(find.text('Reset Password'), findsOneWidget); // Adjust based on the actual screen title.
  });

  testWidgets('Sign Up text navigates correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    await tester.tap(find.text('SIGN UP'));
    await tester.pumpAndSettle();

    // Assuming the signup page has "Create Account" as a title
    expect(find.text('Create Account'), findsOneWidget);
  });

  testWidgets('Social login buttons are displayed', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    expect(find.byIcon(Icons.image), findsNWidgets(3));  // Assumes each social icon is rendered as an icon.
  });

  testWidgets('Email field has correct placeholder', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    final emailField = tester.widget<TextFormField>(find.byType(TextFormField).at(0));
    expect(emailField.decoration?.hintText, 'ex: jon.smith@email.com');
  });

  testWidgets('Password field is obscured', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    final passwordField = tester.widget<TextFormField>(find.byType(TextFormField).at(1));
    expect(passwordField.obscureText, true);
  });

  testWidgets('Share button works (no action expected)', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignInScreen()));

    await tester.tap(find.byIcon(Icons.share));
    await tester.pumpAndSettle();

    // No action for now, just ensure it doesn't cause any issues.
    expect(find.byType(SignInScreen), findsOneWidget);
  });
}

extension on TextFormField {
  get decoration => null;

   get obscureText => null;
}
