import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plate/UI/chat.dart';
import 'package:share_plate/UI/food_listing.dart';

class Reserve extends StatelessWidget {
  final String imagePath;
  final String description;
  final String foodId;
  final FoodItem foodItem;
  final String donorId;
  final String donorEmail; // New parameter for donorEmail

  const Reserve({
    super.key,
    required this.imagePath,
    required this.description,
    required this.foodId,
    required this.foodItem,
    required this.donorId,
    required this.donorEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              // Reserve the item logic
              foodItem.isReserved = true;

              // Mark as reserved in Firestore
              await FirebaseFirestore.instance
                  .collection('food_items')
                  .doc(foodId)
                  .update({
                'isReserved': true,
              });

              Get.to(() => ChatScreen(
                    key: Key('chatScreen'),
                    receiverUserEmail: donorEmail,
                    receiverUserID: donorId,
                  ));

              // Show snackbar
              Get.snackbar(
                'Reserved',
                'Your item has been reserved!',
                duration: const Duration(seconds: 2),
                snackPosition: SnackPosition.TOP,
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              minimumSize: const Size(250, 80),
            ),
            child: const Text(
              'Reserve',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
