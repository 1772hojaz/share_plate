import 'package:flutter/material.dart';
import "package:intl/intl.dart"; // For date formatting

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
  List<Map<String, String>> filteredResults = []; // Filtered search results

  // Example search results (static for now)
  final List<Map<String, String>> searchResults = [
    {'name': 'Pizza', 'expiry': 'Expires in 2 days', 'category': 'Vegetarian'},
    {'name': 'Sandwich', 'expiry': 'Expires today', 'category': 'Vegetarian'},
    {'name': 'Fruit Basket', 'expiry': 'Expires in 3 days', 'category': 'Vegan'},
    {'name': 'Pasta', 'expiry': 'Expires in 4 days', 'category': 'Vegetarian'},
    {'name': 'Bread', 'expiry': 'Expires tomorrow', 'category': 'Gluten-Free'},
  ];

  @override
  void initState() {
    super.initState();
    filteredResults = searchResults; // Initialize filteredResults with all items
  }

  // Function to format the dates
  String formatDate(DateTime date) {
    return DateFormat('EEE, MMM d').format(date);
  }

  // Function to filter search results based on search query
  void filterSearchResults(String query) {
    List<Map<String, String>> tempResults = [];
    if (query.isNotEmpty) {
      tempResults = searchResults
          .where((result) => result['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      tempResults = searchResults; // Show all results if query is empty
    }
    setState(() {
      filteredResults = tempResults;
    });
  }

  // Function to apply filters
  void applyFilters() {
    List<Map<String, String>> tempResults = searchResults.where((result) {
      bool matchesCategory = selectedFilterOption == 'Select' || result['category'] == selectedFilterOption;
      // You can add additional filtering logic based on proximity and date here
      return matchesCategory; // Change as needed to include other filters
    }).toList();

    setState(() {
      filteredResults = tempResults; // Update filtered results based on applied filters
    });
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
                filterSearchResults(value); // Update results as user types
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
                });
              },
              decoration: InputDecoration(
                labelText: 'Filter Options',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),

            // Proximity Slider to select the search range
            Text('Proximity (in km)'),
            Slider(
              value: proximityValue,
              min: 0,
              max: 50,
              divisions: 10,
              label: '${proximityValue.round()} km',
              onChanged: (newValue) {
                setState(() {
                  proximityValue = newValue;
                });
              },
            ),
            SizedBox(height: 16.0),

            // Expiry Date Range Picker
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Start'),
                      TextButton(
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: startDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null && picked != startDate) {
                            setState(() {
                              startDate = picked;
                            });
                          }
                        },
                        child: Text(formatDate(startDate)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('End'),
                      TextButton(
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: endDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null && picked != endDate) {
                            setState(() {
                              endDate = picked;
                            });
                          }
                        },
                        child: Text(formatDate(endDate)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // Apply Filters Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  applyFilters(); // Logic to apply filters and update search results
                },
                child: Text('Apply Filters'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  backgroundColor: Colors.green, // Use backgroundColor instead of primary
                ),
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
                    title: Text(result['name']!),
                    subtitle: Text(result['expiry']!),
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
