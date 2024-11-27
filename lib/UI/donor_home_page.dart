import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  var userName = 'Sarah'.obs;
  var profileImagePath = ''.obs;
}

// Shared Bottom Navigation Bar Widget
class SharedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const SharedBottomNavigationBar({
    super.key,  // Fixed: Changed 'key' to 'super.key'
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
                    const SizedBox(height: 8),
                    // Add Food Container
                    Center(
                      child: SizedBox(
                        width: screenSize.width * 0.6,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(child: Icon(Icons.add, size: 48)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Create Button
                    Center(
                      child: SizedBox(
                        width: screenSize.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement create food listing functionality
                          },
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
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => SharedBottomNavigationBar(
          currentIndex: navigationController.currentIndex.value,
          onTap: (index) {
            navigationController.changePage(index);
            // Add navigation logic here
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