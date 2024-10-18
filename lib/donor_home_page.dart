import 'package:flutter/material.dart';

class DonorHomePage extends StatelessWidget {
  const DonorHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('9:41', style: TextStyle(fontSize: 16)),
                  CircleAvatar(radius: 16, backgroundColor: Colors.grey[300]),
                ],
              ),
            ),
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome back [User Name]! Ready to share surplus food?',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Image.asset(
                      'assets/sharing_is_caring_logo.png',
                      width: screenSize.width * 0.8, // Set width to 80% of screen width
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
                    const Text('Create Food Listing', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Container(
                      height: 120,
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.add, size: 48)),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement create food listing functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Create'),
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