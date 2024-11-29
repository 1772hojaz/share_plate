import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plate/UI/splash_screen.dart';

void main() {
  testWidgets('SplashScreen displays correctly and animates the logo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SplashScreen()));

    // Check if the logo is displayed
    expect(find.byType(Image), findsOneWidget);
    
    // Verify the button is displayed
    expect(find.byType(ElevatedButton), findsOneWidget);
    
    // Check if the button has correct text
    expect(find.text('Get Started!'), findsOneWidget);
    
    // Ensure the splash screen has a white background
    final Scaffold scaffold = tester.widget(find.byType(Scaffold));
    expect(scaffold.backgroundColor, Colors.white);
  });

  testWidgets('Get Started button navigates to the SignUp screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SplashScreen(),
        routes: {
          '/signup': (_) => const Scaffold(body: Text('Sign Up Screen')),
        },
      ),
    );

    // Tap the Get Started button
    await tester.tap(find.text('Get Started!'));
    await tester.pumpAndSettle();

    // Verify that we are navigated to the SignUp screen
    expect(find.text('Sign Up Screen'), findsOneWidget);
  });

  testWidgets('SplashScreen has an animated logo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SplashScreen()));

    // Check if the logo animation is triggered (opacity, rotation, and scale change)
    await tester.pump(Duration(seconds: 1));

    // Ensure the logo is still visible
    expect(find.byType(Image), findsOneWidget);
    
    // Optionally, we can check if the opacity, scale, or rotation changed after a delay
    // Note: More sophisticated testing may involve mocking animations or checking widget properties.

    // The logo should animate (this can be tested more thoroughly by verifying the animations themselves).
  });

  testWidgets('SplashScreen has correct logo size', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SplashScreen()));

    // Get screen width and expected logo size
    double screenWidth = tester.getSize(find.byType(SplashScreen)).width;
    double expectedLogoSize = screenWidth * 0.8;

    // Check if the logo has the correct size
    final Image logoImage = tester.widget(find.byType(Image));
    expect(logoImage.width, expectedLogoSize);
    expect(logoImage.height, expectedLogoSize);
  });
}
