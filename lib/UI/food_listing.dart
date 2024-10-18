import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodListingPageController extends GetxController {
  var foodList = ["User 1", "User 2", "User 3"].obs; // Example donor names
}

class FoodListingPage extends StatelessWidget {
  FoodListingPage({Key? key}) : super(key: key);

  final FoodListingPageController controller = Get.put(FoodListingPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
        elevation: 0, // Remove app bar shadow
        actions: [
          // User profile icon
          GestureDetector(
            onTap: () {
              // Navigate to user profile when clicked
              Get.to(UserProfilePage()); // Use GetX for navigation
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16, top: 16),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/shareplate-icon.jpeg'), // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Image at the top before the list
          Container(
            margin: const EdgeInsets.all(16), // Adds margin around the image
            width: 385,
            height: 146,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), // Corner radius of 16
              image: const DecorationImage(
                image: AssetImage('assets/getameal.jpeg'), // Replace with your image
                fit: BoxFit.cover, // Ensures the image fills the container
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.foodList.length, // Dynamically using GetX state
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        // Food image container with updated dimensions
                        Container(
                          height: 285, //  height  285
                          width: 385, //  width 385
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('assets/shareplateburger1.jpeg'), // Ensure proper image extension
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // "Donated by" text on top-left corner
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Text(
                            "Donated by ${controller.foodList[index]}", // Using dynamic data
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7), // Semi-transparent black
                              fontSize: 12, // Small font size
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          // Bottom navigation bar
          Container(
            height: 95,
            width: 403, // Bottom navigation bar width
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
                    Icon(Icons.volunteer_activism, color: Colors.black), // Appropriate donate icon
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

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: FoodListingPage(), // Entry point to the FoodListingPage
  ));
}
