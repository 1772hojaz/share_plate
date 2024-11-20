import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For date formatting

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedFilterOption = 'Select';
  double proximityValue = 10.0; // Default proximity slider value
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1)); // Default date range
  TextEditingController searchController = TextEditingController(); // Search bar controller
  List<Map<String, dynamic>> filteredResults = []; // Filtered search results

  // Fetch data from Firestore
  Future<List<Map<String, dynamic>>> fetchSearchResults() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('food_items').get();

    // Transform Firestore documents into a list of maps
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // Function to format the dates
  String formatDate(DateTime date) {
    return DateFormat('EEE, MMM d').format(date);
  }

  // Function to filter search results based on search query and filters
  void filterSearchResults() async {
    String query = searchController.text.toLowerCase();
    List<Map<String, dynamic>> allResults = await fetchSearchResults();
    List<Map<String, dynamic>> tempResults = allResults.where((result) {
      bool matchesQuery = query.isEmpty ||
          (result['name'] as String).toLowerCase().contains(query);
      bool matchesCategory = selectedFilterOption == 'Select' ||
          result['category'] == selectedFilterOption;
      // Add logic for proximity and date filtering if needed
      return matchesQuery && matchesCategory;
    }).toList();

    setState(() {
      filteredResults = tempResults;
    });
  }

  @override
  void initState() {
    super.initState();
    filterSearchResults(); // Initial fetch of all data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Food Search')),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Search bar for searching food items
            TextField(
              controller: searchController,
              onChanged: (value) {
                filterSearchResults(); // Update results as user types
              },
              decoration: InputDecoration(
                labelText: 'Find Food Here',
                hintText: 'Search for food items',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),

            // Filter Options Dropdown for food categories
            DropdownButtonFormField<String>(
              value: selectedFilterOption,
              items: <String>['Select', 'Vegetarian', 'Vegan', 'Gluten-Free', 'Dairy-Free']
                  .map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFilterOption = newValue!;
                  filterSearchResults();
                });
              },
              decoration: InputDecoration(
                labelText: 'Filter Options',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),

            // Search Results Section
            Text('Search Results', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),

            // Search Result ListView
            Expanded(
              child: filteredResults.isNotEmpty
                  ? ListView.builder(
                itemCount: filteredResults.length,
                itemBuilder: (context, index) {
                  final result = filteredResults[index];
                  return ListTile(
                    title: Text(result['name']),
                    subtitle: Text(result['expiry']),
                  );
                },
              )
                  : Center(child: Text('No results found.')),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Donate'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: 2, // Since this is the search screen, set the current index to 2.
        selectedItemColor: Colors.green,
        onTap: (index) {
          // Handle bottom navigation tap events
          if (index == 0) {
            // Navigate to Home screen
          } else if (index == 1) {
            // Navigate to Donate screen
          } else if (index == 2) {
            // Already on Search screen
          }
        },
      ),
    );
  }
}
