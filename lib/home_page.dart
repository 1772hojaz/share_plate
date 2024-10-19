import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'SharePlate Rwanda',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              // Handle profile button click
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Image
            Image.asset(
              'assets/images/food_sharing.jpg', // Replace with your actual image path
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            // Text under the banner with green background
            Container(
              color: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: const Text(
                'The most trusted food sharing app!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Donation and Reception buttons layout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Donation button
                buildFoodButton(
                  'Donate food',
                  'assets/images/donate_food.jpg',
                  () {
                    // Handle Donate Food click
                  },
                ),
                // Reception button
                buildFoodButton(
                  'Receive food',
                  'assets/images/receive_food.jpg',
                  () {
                    // Handle Receive Food click
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.black,
        unselectedItemColor:
            Colors.black, // Make the unselected item color the same as selected
        showSelectedLabels:
            true, // Ensure labels are visible for selected items
        showUnselectedLabels:
            true, // Ensure labels are visible for unselected items
        selectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }

  // Reusable function for creating uniform food buttons
  Widget buildFoodButton(String label, String imagePath, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: 127, // Decreased width of the button
        height: 214, // Decreased height of the button
        decoration: BoxDecoration(
          color: Colors.grey[200], // Gray background
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Green Header for the Button Text
            Container(
              color: Colors.green,
              padding: const EdgeInsets.symmetric(
                  vertical: 8), // Decreased vertical padding
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 8, // Decreased font size
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Image below the green text section
            Padding(
              padding:
                  const EdgeInsets.all(8.0), // Add some padding for the image
              child: Image.asset(
                imagePath,
                height: 80, // Decreased height of the image inside the button
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
