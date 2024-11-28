import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plate/UI/reserve.dart';

// Model class for food items
class FoodItem {
  String donorId;
  String donorEmail;
  String image; // Image URL
  String description;
  bool isReserved;
  String id; // Firestore document ID

  FoodItem({
    required this.donorId,
    required this.donorEmail,
    required this.image,
    required this.description,
    this.isReserved = false,
    required this.id,
  });

  // Convert a Firestore document to FoodItem object
  factory FoodItem.fromFirestore(Map<String, dynamic> data, String id) {
    return FoodItem(
      donorId: data['donor_Id'] ?? '',
      donorEmail: data['donor_Email'] ?? '',
      image: data['image_url'] ?? '',
      description: data['description'] ?? '',
      isReserved: data['isReserved'] ?? false,
      id: id,
    );
  }

  // Convert FoodItem to Map for Firestore upload
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'description': description,
      'isReserved': isReserved,
    };
  }
}

// Controller for managing food listings
class FoodListingPageController extends GetxController {
  var foodList = <FoodItem>[].obs;

  // Fetch food items from Firestore
  Future<void> fetchFoodItems() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('food_items').get();
      foodList.value = querySnapshot.docs.map((doc) {
        return FoodItem.fromFirestore(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch food items: $e");
    }
  }
}

// The main FoodListingPage
class FoodListingPage extends StatelessWidget {
  FoodListingPage({super.key});

  final FoodListingPageController controller =
      Get.put(FoodListingPageController());

  @override
  Widget build(BuildContext context) {
    // Load food items from Firestore when the page is loaded
    controller.fetchFoodItems();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed('/chat'); // Navigate to chat page
            },
            child: const Icon(
              Icons.message, // Message icon
              color: Color.fromARGB(255, 14, 7, 7), // Icon color
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const UserProfilePage());
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
          // Chat Icon
        ],
      ),
      body: Column(
        children: [
          // Header image
          Container(
            margin: const EdgeInsets.all(16),
            width: 385,
            height: 146,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/getameal.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Food items list
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.foodList.length,
                itemBuilder: (context, index) {
                  var foodItem = controller.foodList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => Reserve(
                            imagePath: foodItem.image,
                            description: foodItem.description,
                            foodId: foodItem.id,
                            foodItem: foodItem,
                            donorId: foodItem.donorId,
                            donorEmail: foodItem.donorEmail,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          // Food item image
                          Container(
                            height: 285,
                            width: 385,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(foodItem.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Food description overlay
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              foodItem.description,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                          // Reserved indicator
                          if (foodItem.isReserved)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: Colors.green,
                                child: const Text(
                                  'Reserved',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          // Bottom navigation bar
          // Bottom navigation bar
          Container(
            height: 95,
            width: 403,
            color: const Color(0xFF00B140),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home Button
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/home'); // Navigate to Home page
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.home, color: Colors.black),
                      Text('Home', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                // Donate Button
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/donate'); // Navigate to Donate page
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.volunteer_activism, color: Colors.black),
                      Text('Donate', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                // Search Button
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/search'); // Navigate to Search page
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
          )
        ],
      ),
    );
  }
}

// Example UserProfilePage (for demo purposes, replace with your actual profile page)
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
