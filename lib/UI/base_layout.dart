import 'package:flutter/material.dart';
import 'package:get/get.dart';

// BaseLayout widget
class BaseLayout extends StatefulWidget {
  final Widget body; // The body of the page
  final int? selectedIndex; // Nullable index for the bottom nav bar

  // Constructor
  const BaseLayout({
    super.key,
    required this.body,
    this.selectedIndex,
  });

  @override
  _BaseLayoutState createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    // Initialize index from widget or default to -1 (no navbar)
    _selectedIndex = widget.selectedIndex ?? -1;
  }

  // Method to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });

    // Navigate to the appropriate page based on the index
    if (index == 0) {
      Get.toNamed('/home'); // Navigate to home page
    } else if (index == 1) {
      Get.toNamed('/donate'); // Navigate to donate page
    } else if (index == 2) {
      Get.toNamed('/search'); // Navigate to search page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Share Plate")), // Optional AppBar for each screen
      body: widget.body, // Display the passed body
      // Only show Navbar if index is valid (not -1)
      bottomNavigationBar: _selectedIndex == -1
          ? null
          : Navbar(
              selectedIndex:
                  _selectedIndex, // Pass the selected index to Navbar
              onTap: _onItemTapped, // Handle item tap
            ),
    );
  }
}

// Navbar widget that handles the bottom navigation bar
class Navbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const Navbar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      width: 403,
      color: const Color(0xFF00B140), // Background color for navbar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home,
            label: 'Home',
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.volunteer_activism,
            label: 'Donate',
            index: 1,
          ),
          _buildNavItem(
            icon: Icons.search,
            label: 'Search',
            index: 2,
          ),
        ],
      ),
    );
  }

  // Helper method to build each navigation item
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => onTap(index), // Trigger navigation on tap
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selectedIndex == index
                ? Colors.blue
                : Colors.black, // Highlight selected item
          ),
          Text(
            label,
            style: TextStyle(
                color: selectedIndex == index
                    ? Colors.blue
                    : Colors.black), // Highlight selected text
          ),
        ],
      ),
    );
  }
}
