import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';
import 'user_profile_page.dart';

// Navigation Controller for managing bottom nav state
class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}

// Donor Home Controller for managing donor-specific state
class DonorHomeController extends GetxController {
  final firebaseService = Get.find<FirebaseService>();
  var userName = ''.obs;
  var profileImagePath = ''.obs;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final userData = await firebaseService.getUserData();
      if (userData != null && userData.exists) {
        final data = userData.data() as Map<String, dynamic>;
        userName.value = data['name'] ?? '';
        profileImagePath.value = data['profileImage'] ?? '';
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  Future<void> createFoodListing() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await FirebaseFirestore.instance.collection('food_items').add({
        'donor_id': firebaseService.currentUser.value?.uid,
        'description': descriptionController.text,
        'quantity': int.parse(quantityController.text),
        'pickup_location': locationController.text,
        'status': 'available',
        'created_at': FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        'Success',
        'Food listing created successfully',
        backgroundColor: Colors.green[100],
      );

      // Clear form
      descriptionController.clear();
      quantityController.clear();
      locationController.clear();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create food listing',
        backgroundColor: Colors.red[100],
      );
    }
  }

  @override
  void onClose() {
    descriptionController.dispose();
    quantityController.dispose();
    locationController.dispose();
    super.onClose();
  }
}

// Shared Bottom Navigation Bar Widget
class SharedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const SharedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black,
        ),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => onTap(0),
              child: _buildNavItem(
                Icons.home,
                'Home',
                currentIndex == 0,
              ),
            ),
            InkWell(
              onTap: () => onTap(1),
              child: _buildNavItem(
                Icons.card_giftcard,
                'Donate',
                currentIndex == 1,
              ),
            ),
            InkWell(
              onTap: () => onTap(2),
              child: _buildNavItem(
                Icons.search,
                'Search',
                currentIndex == 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Main Donor Home Page
class DonorHomePage extends GetView<DonorHomeController> {
  const DonorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    Get.put(DonorHomeController());
    final navigationController = Get.put(NavigationController());
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Profile Picture
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserProfilePage(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage('assets/default_profile.jpg'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // Welcome Message
                      Obx(() => Text(
                        'Welcome back ${controller.userName.value}! Ready to share surplus food?',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                      const SizedBox(height: 16),
                      // Logo
                      Image.asset(
                        'assets/sharing_is_caring_logo.png',
                        width: screenSize.width * 0.8,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      // Create Food Listing Section
                      const Text('Create Food Listing',
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      // Food Listing Form
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.descriptionController,
                              decoration: const InputDecoration(
                                labelText: 'Food Description',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) =>
                              value?.isEmpty ?? true ? 'Please enter a description' : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: controller.quantityController,
                              decoration: const InputDecoration(
                                labelText: 'Quantity (kg)',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                              value?.isEmpty ?? true ? 'Please enter quantity' : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: controller.locationController,
                              decoration: const InputDecoration(
                                labelText: 'Pickup Location',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) =>
                              value?.isEmpty ?? true ? 'Please enter pickup location' : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Create Button
                      Center(
                        child: SizedBox(
                          width: screenSize.width * 0.6,
                          child: ElevatedButton(
                            onPressed: () => controller.createFoodListing(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Create',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
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
      bottomNavigationBar: Obx(
            () => SharedBottomNavigationBar(
          currentIndex: navigationController.currentIndex.value,
          onTap: (index) {
            navigationController.changePage(index);
            switch (index) {
              case 0:
              // Already on home page
                break;
              case 1:
              // Navigate to Donate page
              // Get.to(() => const DonatePage());
                break;
              case 2:
              // Navigate to Search page
              // Get.to(() => const SearchPage());
                break;
            }
          },
        ),
      ),
    );
  }
}