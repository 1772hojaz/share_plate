import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:share_plate/UI/terms.dart';
import 'package:share_plate/services/auth_service.dart';
import 'signin_page.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

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
              _buildTextField("Name", "ex: Jon Smith",
                  controller: _nameController),
              const SizedBox(height: 15),
              _buildTextField("Email", "ex: jon.smith@gmail.com",
                  controller: _emailController),
              const SizedBox(height: 15),
              _buildTextField("Location", "ex: Kigali, Kimironko",
                  controller: _locationController),
              const SizedBox(height: 15),
              _buildTextField("Password", "********",
                  isPassword: true, controller: _passwordController),
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
                  onPressed: () async {
                    await AuthService().signup(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        location: _locationController.text,
                        context: context);
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
                  _buildSocialButton('assets/images/Google_Icons-09-512.webp',
                      () {
                    // Handle Google sign-up logic
                    print("Signing up with Google...");
                  }),
                  const SizedBox(width: 10),
                  _buildSocialButton('assets/images/facebook.png', () {
                    // Handle Facebook sign-up logic
                    print("Signing up with Facebook...");
                  }),
                  const SizedBox(width: 10),
                  _buildSocialButton('assets/images/images.png', () {
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

  Widget _buildTextField(
    String label,
    String hint, {
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
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
    Get.to(() => TermsPage()); // Navigate to details page
  }

  void _navigateToSignIn() {
    // Navigate to the sign-in screen or handle sign-in logic
    // Replace this comment with actual navigation code
    Get.to(() => SignInScreen());
    print("Navigating to Sign In screen");
  }
}
