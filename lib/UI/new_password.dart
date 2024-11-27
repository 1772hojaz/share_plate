import 'package:flutter/material.dart';

// New Password Screen widget
class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar background color
        elevation: 0, // No shadow
        iconTheme: const IconThemeData(
          color: Colors.black, // Icon color for AppBar
        ),
      ),
      body: SafeArea(
        child: Center(
          // Center the entire body content
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Align items to the top
            children: [
              const SizedBox(height: 20), // Spacer at the top
              const Text(
                "New Password", // Title text
                style: TextStyle(
                  fontSize: 30, // Font size for title
                  fontWeight: FontWeight.w700, // Bold font weight
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Padding around description
                child: Text(
                  "Please enter your new password below.", // Description text
                  style: TextStyle(
                    color: Color(0xFF8391A1), // Text color
                    fontSize: 16, // Font size
                    fontWeight: FontWeight.w500, // Medium font weight
                  ),
                  textAlign: TextAlign.center, // Center the description text
                ),
              ),
              const SizedBox(height: 80), // Spacer before input fields
              // New Password Field
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20), // Horizontal padding
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFFF7F8F9), // Background color of the input field
                    border: Border.all(
                      color: const Color(0xFFE8ECF4), // Border color
                    ),
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10), // Padding inside the container
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none, // No border around the input
                        hintText: 'Enter new password', // Placeholder text
                        hintStyle: TextStyle(
                          color: Color(0xFF8391A1), // Hint text color
                        ),
                      ),
                      obscureText: true, // Hide password input
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 40), // Spacer before confirm password field
              // Confirm Password Field
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20), // Horizontal padding
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFFF7F8F9), // Background color of the input field
                    border: Border.all(
                      color: const Color(0xFFE8ECF4), // Border color
                    ),
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10), // Padding inside the container
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none, // No border around the input
                        hintText: 'Confirm New Password', // Placeholder text
                        hintStyle: TextStyle(
                          color: Color(0xFF8391A1), // Hint text color
                        ),
                      ),
                      obscureText: true, // Hide password input
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40), // Spacer before the button
              // Reset Password Button
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 10), // Horizontal padding
                child: SizedBox(
                  width: 450,
                  child: MaterialButton(
                    color: const Color(0xff00b140), // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    onPressed: () {
                      // It will then redirect to sign in page - will insert the code
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.all(15.0), // Padding inside the button
                      child: Text(
                        "Confirm", // Button text
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16, // Font size
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(), // Spacer before the remember password section
              // Remember Password? Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the row
                children: [
                  const Text(
                    "Remember your password? ", // Reminder text
                    style: TextStyle(
                      fontSize: 16, // Font size
                      fontWeight: FontWeight.w500, // Medium font weight
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add navigation to the login screen here
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewPasswordScreen()));
                    },
                    child: const Text(
                      "Login", // Link text
                      style: TextStyle(
                        color: Color(0xFF35C2C1), // Link color
                        fontSize: 16, // Font size
                        fontWeight: FontWeight.w700, // Bold font weight
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
}
