import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_profile_page.dart';

class DonorHomeController extends GetxController {
  // This would be populated with actual user data in a real app
  var userName = 'Sarah'.obs;  // Example name
  var profileImagePath = ''.obs;
}

class DonorHomePage extends GetView<DonorHomeController> {
  const DonorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DonorHomeController());
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
            // Main content with adjusted spacing
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Obx(() => Text(
                      'Welcome back ${controller.userName.value}! Ready to share surplus food?',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(height: 16), // Reduced space
                    Image.asset(
                      'assets/sharing_is_caring_logo.png',
                      width: screenSize.width * 0.8,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 16), // Reduced space
                    const Text('Create Food Listing',
                        style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    // Centered container with reduced width
                    Center(
                      child: SizedBox(
                        width: screenSize.width * 0.6, // 60% of screen width
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
                    // Centered button with reduced width and more rounded corners
                    Center(
                      child: SizedBox(
                        width: screenSize.width * 0.6, // 60% of screen width
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement create food listing functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white, // Ensures text is white
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // More rounded corners
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home'),
              _buildNavItem(Icons.card_giftcard, 'Donate'),
              _buildNavItem(Icons.search, 'Search'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.black),
        Text(label, style: const TextStyle(color: Colors.black, fontSize: 12)),
      ],
    );
  }
}