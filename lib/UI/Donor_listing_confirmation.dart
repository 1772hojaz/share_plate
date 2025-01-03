import 'package:flutter/material.dart';

// DonorListingConfirmationPage.dart
class DonorListingConfirmationPage extends StatelessWidget {
  final String description;
  final int quantity;
  final String location;
  final String imageUrl;

  const DonorListingConfirmationPage({
    super.key,
    required this.description,
    required this.quantity,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listing Confirmation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.green, size: 100),
            const SizedBox(height: 16),
            const Text(
              "Your food listing has been successfully created!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display food listing details
            Text("Description: $description"),
            Text("Quantity: $quantity kg"),
            Text("Pickup Location: $location"),

            const SizedBox(height: 20),

            // View Other Listings Button
            ElevatedButton(
              onPressed: () {
                // Navigate to Food Listings page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FoodListingsPage()),
                );
              },
              child: const Text("View Other Listings"),
            ),

            const SizedBox(height: 10),

            // Log Out Button
            ElevatedButton(
              onPressed: () {
                // Navigate back to the main screen, clearing any intermediate routes
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}

// Example placeholder page for Food Listings
class FoodListingsPage extends StatelessWidget {
  const FoodListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Food Listings")),
      body: const Center(
        child: Text(
          "Here you will see all available food listings.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
