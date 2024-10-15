import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Importing gestures.dart for TapGestureRecognizer

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isChecked = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back navigation
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField("Name", "ex: Jon Smith"),
              const SizedBox(height: 15),
              _buildTextField("Email", "ex: jon.smith@gmail.com"),
              const SizedBox(height: 15),
              _buildTextField("Location", "ex: Kigali, Kimironko"),
              const SizedBox(height: 15),
              _buildTextField("Password", "********", isPassword: true),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'I understand the ',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'terms & policy',
                          style: const TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Handle the terms and policy action here
                              _showTermsAndPolicy();
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle sign-up logic
                    print("Signing Up...");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Use backgroundColor instead of primary
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "or sign up with",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton('assets/images/google.png', () {
                    // Handle Google sign-up logic
                    print("Signing up with Google...");
                  }),
                  const SizedBox(width: 10),
                  _buildSocialButton('assets/images/facebook.png', () {
                    // Handle Facebook sign-up logic
                    print("Signing up with Facebook...");
                  }),
                  const SizedBox(width: 10),
                  _buildSocialButton('assets/images/twitter.jpeg', () {
                    // Handle Twitter sign-up logic
                    print("Signing up with Twitter...");
                  }),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Handle sign-in logic here
                    _navigateToSignIn();
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Have an account? ',
                      style: TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: 'SIGN IN',
                          style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: InputBorder.none, // Remove border
        enabledBorder: InputBorder.none, // Remove enabled border
        focusedBorder: InputBorder.none, // Remove focused border
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget _buildSocialButton(String imagePath, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey[200],
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }

  void _showTermsAndPolicy() {
    // Show a dialog or navigate to a terms and policy page
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Terms and Policy"),
          content: const Text("Here you can display your terms and policy."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToSignIn() {
    // Navigate to the sign-in screen or handle sign-in logic
    // Replace this comment with actual navigation code
    print("Navigating to Sign In screen");
  }
}
