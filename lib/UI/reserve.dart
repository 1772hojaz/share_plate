import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat.dart';

class Reserve extends StatelessWidget {
  final String imagePath; // Image path passed from the listings page
  final String description; // Description of the food

  const Reserve({super.key, required this.imagePath, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back to the food listings page
            Get.back();
          },
        ),
        actions: [
          // User profile icon
          GestureDetector(
            onTap: () {
              Get.to(UserProfilePage());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16, top: 16),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/shareplate-icon.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Display the clicked food image
          Container(
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Display food description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          // Reserve button
          ElevatedButton(
            onPressed: () {
              // // Show notification
              // Get.snackbar(
              //   'Reserved',
              //   'Your item has been reserved!',
              //   duration: Duration(seconds: 2), // Show for 2 seconds
              //   snackPosition: SnackPosition.TOP, // Position at the bottom
              // );

              // // Navigate to ReservationPage after the notification
              // Future.delayed(Duration(seconds: 2), () {
              //   Get.to(ChatScreen());
              // });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green, // Background color
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              minimumSize: const Size(250, 80),
            ),
            child: const Text(
              'Reserve',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 16),
          // Bottom navigation bar
          Spacer(),
          Container(
            height: 95,
            width: double.infinity,
            color: const Color(0xFF00B140),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home, color: Colors.black),
                    Text('Home', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.volunteer_activism, color: Colors.black),
                    Text('Donate', style: TextStyle(color: Colors.black)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search, color: Colors.black),
                    Text('Search', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Example UserProfilePage (Replace this with your actual profile page)
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: const Center(
        child: Text("User Profile Page"),
      ),
    );
  }
}
