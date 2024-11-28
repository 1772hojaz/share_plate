import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plate/UI/chat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Color _accentColor = const Color(0xFF272727);

  // Current selected index for the bottom navigation bar
  int _selectedIndex = 0;

  // Method to handle item tap on bottom navigation
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    // Handle the navigation based on the index
    if (index == 0) {
      Get.toNamed('/home'); // Navigate to Home
    } else if (index == 1) {
      Get.toNamed('/donate'); // Navigate to Donate page
    } else if (index == 2) {
      Get.toNamed('/search'); // Navigate to Search page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w700,
                    color: _accentColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Expanded(
                      child: _buildUserList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 95,
        color: const Color(0xFF00B140),
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
      ),
    );
  }

  // Builds the navigation item with an icon and label
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return GestureDetector(
      onTap: () =>
          _onNavItemTapped(index), // Navigate to the corresponding page
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? Colors.black
                : Colors.black, // Highlight selected item
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index
                  ? Colors.black
                  : Colors.black, // Highlight selected text
            ),
          ),
        ],
      ),
    );
  }

  /// Fetches the list of users dynamically.
  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading users'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No users found'));
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserTile(doc))
              .toList(),
        );
      },
    );
  }

  /// Builds a single user tile with navigation to ChatScreen.
  Widget _buildUserTile(DocumentSnapshot document) {
    final Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser?.email == data['email']) {
      return Container(); // Skip current user.
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => ChatScreen(
              key: Key('chatScreen'),
              receiverUserEmail: data['email'],
              receiverUserID: data['uid'],
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'] ?? data['email'],
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    data['status'] ?? "No status available",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16.0),
          ],
        ),
      ),
    );
  }
}
