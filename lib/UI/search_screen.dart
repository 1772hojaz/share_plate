import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';

class SearchController extends GetxController {
  // Observables for search fields
  var searchQuery = ''.obs;
  var locationFilter = ''.obs;
  var minQuantityFilter = 0.obs;
  var maxQuantityFilter = 100.obs;
  var isAvailableFilter = true.obs;

  // Observable for search results
  var foodItems = <DocumentSnapshot>[].obs;

  // Firebase service
  final firebaseService = Get.find<FirebaseService>();

  // Debounced search function to avoid frequent calls
  Timer? _debounce;

  // Method to execute the search query
  void searchFoodItems() async {
    // Cancel any existing debounce timer
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    // Set a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        Query query = FirebaseFirestore.instance.collection('food_items');

        // Filter by description (search query)
        if (searchQuery.value.isNotEmpty) {
          query = query
              .where('description', isGreaterThanOrEqualTo: searchQuery.value)
              .where('description',
                  isLessThanOrEqualTo: searchQuery.value + '\uf8ff');
        }

        // Filter by location
        if (locationFilter.value.isNotEmpty) {
          query =
              query.where('pickup_location', isEqualTo: locationFilter.value);
        }

        // Filter by quantity range
        query = query
            .where('quantity', isGreaterThanOrEqualTo: minQuantityFilter.value)
            .where('quantity', isLessThanOrEqualTo: maxQuantityFilter.value);

        // Filter by availability status
        query = query.where('status',
            isEqualTo: isAvailableFilter.value ? 'available' : 'unavailable');

        // Fetch the results
        final result = await query.get();
        foodItems.value = result.docs;
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch food items: $e',
            backgroundColor: Colors.red[100]);
      }
    });
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.put(SearchController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Food Items'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar for description
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search for food...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                searchController.searchQuery.value = query;
                searchController.searchFoodItems();
              },
            ),
            const SizedBox(height: 16),

            // Location filter
            TextField(
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              onChanged: (location) {
                searchController.locationFilter.value = location;
                searchController.searchFoodItems();
              },
            ),
            const SizedBox(height: 16),

            // Quantity filter (range)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Min Quantity (kg)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      searchController.minQuantityFilter.value =
                          int.tryParse(value) ?? 0;
                      searchController.searchFoodItems();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Max Quantity (kg)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      searchController.maxQuantityFilter.value =
                          int.tryParse(value) ?? 100;
                      searchController.searchFoodItems();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Availability filter
            Row(
              children: [
                const Text('Available'),
                Obx(() {
                  return Switch(
                    value: searchController.isAvailableFilter.value,
                    onChanged: (value) {
                      searchController.isAvailableFilter.value = value;
                      searchController.searchFoodItems();
                    },
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),

            // Display search results
            Expanded(
              child: Obx(() {
                if (searchController.foodItems.isEmpty) {
                  return const Center(child: Text('No food items found.'));
                }

                return ListView.builder(
                  itemCount: searchController.foodItems.length,
                  itemBuilder: (context, index) {
                    var foodItem = searchController.foodItems[index].data()
                        as Map<String, dynamic>;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      leading: foodItem['image_url'] != null
                          ? Image.network(foodItem['image_url'],
                              width: 50, height: 50, fit: BoxFit.cover)
                          : const Icon(Icons.fastfood, size: 50),
                      title: Text(foodItem['description'] ?? 'No description'),
                      subtitle: Text(
                          'Location: ${foodItem['pickup_location'] ?? 'N/A'}\nQuantity: ${foodItem['quantity']} kg'),
                      trailing: foodItem['status'] == 'available'
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.cancel, color: Colors.red),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
