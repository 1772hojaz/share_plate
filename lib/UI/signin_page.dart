import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const SignInPage());
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              // Back Arrow & Share Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.black, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Sign In Text
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Email Input Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'ex: jon.smith@email.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF7F8F9),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password Input Field
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: '••••••••',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF7F8F9),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                ),
              ),
              const SizedBox(height: 8),

              // Forgot Password Text
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sign In Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // OR sign in with text
              const Text(
                'or sign in with',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Social Login Buttons (Google, Facebook, Twitter)
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    IconButton(
      icon: Image.asset(
        'assets/images/Google_Icons-09-512.webp',
        width: 40,
      ),
      onPressed: () {},
    ),
    IconButton(
      icon: Image.asset(
        'assets/images/facebook.png',
        width: 40,
      ),
      onPressed: () {},
    ),
    IconButton(
      icon: Image.asset(
        'assets/images/images.png',
        width: 40,
      ),
      onPressed: () {},
    ),
  ],
),
const SizedBox(height: 24),

              // Sign Up Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return IconButton(
      icon: Image.asset(
        assetPath,
        width: 40,
        height: 40,
      ),
      onPressed: () {},
    );
  }
}
