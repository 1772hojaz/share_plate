import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionCompletionPage extends StatelessWidget {
  const TransactionCompletionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2), // Black border
                    borderRadius: BorderRadius.circular(8), // Slightly rounded edges
                  ),
                  child: Text(
                    "Transaction Successful!",
                    style: TextStyle(
                      color: const Color(0xFF1F2937),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Text(
                "Transaction Details",
                style: TextStyle(
                  color: const Color(0xFF374151),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Food item:",
                style: TextStyle(
                  color: const Color(0xFF4B5563),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Burger",
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Quantity:",
                style: TextStyle(
                  color: const Color(0xFF4B5563),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "2",
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Recipient:",
                style: TextStyle(
                  color: const Color(0xFF4B5563),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "John Doe",
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Pickup Date:",
                style: TextStyle(
                  color: const Color(0xFF4B5563),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "October 4, 2024",
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3B82F6), // Blue button
                    minimumSize: const Size(322, 56), // Button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    // Navigate to feedback form (to be added later)
                    // Get.to(FeedbackFormPage());
                  },
                  icon: const Icon(Icons.feedback, color: Colors.white),
                  label: const Text(
                    "Give Feedback",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFF00B140),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                // Navigate to Home Page
                // Get.to(HomePage());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.home, color: Colors.black),
                  Text('Home', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Donate Page
                // Get.to(DonatePage());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.volunteer_activism, color: Colors.black),
                  Text('Donate', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Search Page
                // Get.to(SearchPage());
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.search, color: Colors.black),
                  Text('Search', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: const TransactionCompletionPage(), // Entry point to the Transaction Completion Page
  ));
}
