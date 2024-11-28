// import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   // Firebase Firestore instance
//   // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   // final FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           'SharePlate Rwanda',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//             fontFamily: 'Poppins',
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.account_circle, color: Colors.black),
//             onPressed: () {
//               // Navigate to profile or handle user login/logout
//               handleProfile(context);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Banner Image
//             Image.asset(
//               'assets/images/food_sharing.jpg',
//               height: 150,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),

//             // Text under the banner with green background
//             Container(
//               color: Colors.green,
//               padding: const EdgeInsets.symmetric(vertical: 12.0),
//               child: const Text(
//                 'The most trusted food sharing app!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: 'Poppins',
//                   fontSize: 14,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Donation and Reception buttons layout
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // Donation button
//                 buildFoodButton(
//                   'Donate food',
//                   'assets/images/donate_food.jpg',
//                       () {
//                     handleDonateFood();
//                   },
//                 ),
//                 // Reception button
//                 buildFoodButton(
//                   'Receive food',
//                   'assets/images/receive_food.jpg',
//                       () {
//                     handleReceiveFood();
//                   },
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),

//       // Bottom Navigation Bar
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.green,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//         unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fastfood),
//             label: 'Donate',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//         ],
//       ),
//     );
//   }

//   // Reusable function for creating uniform food buttons
//   Widget buildFoodButton(String label, String imagePath, Function onTap) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         width: 127,
//         height: 214,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Green Header for the Button Text
//             Container(
//               color: Colors.green,
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Text(
//                 label,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 8,
//                   color: Colors.white,
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Image below the green text section
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Image.asset(
//                 imagePath,
//                 height: 80,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Handle Donate Food action and add data to Firestore
// //  void handleDonateFood() async {
//   //  try {
//   //    final user = _auth.currentUser;
//    //   if (user != null) {
//    //     await _firestore.collection('donations').add({
//    //       'userId': user.uid,
//     //      'food': 'Food donated',  // You can add more details like food type
//     //      'timestamp': FieldValue.serverTimestamp(),
//    //     });
//      //   // Notify the user that donation was successful
//    //     print('Donation added to Firestore');
//    //   } else {
//   //      // Handle user not logged in
//         print('User not logged in');
//  //     }
//  //   } catch (e) {
//  //     print('Error donating food: $e');
//  //   }
// //  }

//   // Handle Receive Food action and fetch data from Firestore
// //  void handleReceiveFood() async {
// //    try {
// //      final user = _auth.currentUser;
// //      if (user != null) {
//  //       final snapshot = await _firestore.collection('donations').get();
//         // Display data (you could show this in a list or dialog)
//     //    snapshot.docs.forEach((doc) {
//   //        print(doc['food']);
//    //     });
//    //   } else {
//    //     print('User not logged in');
//  //     }
//  //   } catch (e) {
//   //    print('Error receiving food: $e');
//   //  }
// //  }

//   // Handle user profile (login, logout, or navigation)
//   void handleProfile(BuildContext context) {
// //    final user = _auth.currentUser;
//   //  if (user != null) {
//       // Show a logout dialog or navigate to the profile page
//    //   print('User is logged in');
// //} else {
//       // Navigate to the login screen
//       Navigator.pushNamed(context, '/login');
//     }
//   }
// }
