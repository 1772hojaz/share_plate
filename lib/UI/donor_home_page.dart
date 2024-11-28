import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../services/firebase_service.dart';
import 'user_profile_page.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  _DonorHomePageState createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  final firebaseService = Get.find<FirebaseService>();

  // State Variables
  String userName = '';
  String profileImagePath = '';
  String foodImagePath = '';
  String cloudinaryImageUrl = '';

  // Form Controllers
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final quantityController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      final userData = await firebaseService.getUserData();
      if (userData != null && userData.exists) {
        final data = userData.data() as Map<String, dynamic>;
        setState(() {
          userName = data['name'] ?? '';
          profileImagePath = data['profileImage'] ?? '';
        });
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  // Pick image and save locally
  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        final imageFile = File(pickedFile.path);
        setState(() {
          foodImagePath = imageFile.path;
        });
        return imageFile;
      } catch (e) {
        print('Error picking image: $e');
        Get.snackbar(
          'Error',
          'Failed to pick image: $e',
          backgroundColor: Colors.red[100],
        );
        return null;
      }
    } else {
      print("No image selected");
      Get.snackbar(
        'Cancelled',
        'No image selected',
        backgroundColor: Colors.orange[100],
      );
      return null;
    }
  }

  // Upload image to Cloudinary
  Future<String?> uploadToCloudinary(File imageFile) async {
    try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dz5rslegb/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'gko80j9h'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        return jsonMap['secure_url'];
      }
      return null;
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      Get.snackbar(
        'Error',
        'Failed to upload to Cloudinary: $e',
        backgroundColor: Colors.red[100],
      );
      return null;
    }
  }

  // Create food listing
  Future<void> createFoodListing() async {
    if (!formKey.currentState!.validate() || foodImagePath.isEmpty) {
      Get.snackbar(
        'Incomplete',
        'Please fill all fields and upload an image',
        backgroundColor: Colors.red[100],
      );
      return;
    }

    try {
      final localFile = File(foodImagePath);
      final cloudinaryUrl = await uploadToCloudinary(localFile);

      if (cloudinaryUrl == null) {
        Get.snackbar(
          'Error',
          'Failed to create listing: Could not upload image',
          backgroundColor: Colors.red[100],
        );
        return;
      }

      await FirebaseFirestore.instance.collection('food_items').add({
        'donor_Email': FirebaseAuth.instance.currentUser?.email ?? '',
        'donor_id': firebaseService.currentUser.value?.uid,
        'description': descriptionController.text,
        'quantity': int.parse(quantityController.text),
        'pickup_location': locationController.text,
        'image_url': cloudinaryUrl,
        'status': 'available',
        'created_at': FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        'Success',
        'Food listing created successfully',
        backgroundColor: Colors.green[100],
      );

      // Clear form
      setState(() {
        descriptionController.clear();
        quantityController.clear();
        locationController.clear();
        foodImagePath = '';
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create listing: $e',
        backgroundColor: Colors.red[100],
      );
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    quantityController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserProfilePage(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage: profileImagePath.isEmpty
                            ? const AssetImage('assets/default_profile.jpg')
                            : NetworkImage(profileImagePath) as ImageProvider,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Welcome back $userName! Ready to share surplus food?',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Image.asset(
                        'assets/sharing_is_caring_logo.png',
                        width: screenSize.width * 0.8,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      const Text('Create Food Listing',
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 16),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                labelText: 'Food Description',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter a description'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: quantityController,
                              decoration: const InputDecoration(
                                labelText: 'Quantity (kg)',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter quantity'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: locationController,
                              decoration: const InputDecoration(
                                labelText: 'Pickup Location',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => value?.isEmpty ?? true
                                  ? 'Please enter pickup location'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            foodImagePath.isEmpty
                                ? ElevatedButton(
                                    onPressed: () async {
                                      await pickImage();
                                    },
                                    child: const Text('Upload Image'),
                                  )
                                : Image.file(File(foodImagePath)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          width: screenSize.width * 0.6,
                          child: ElevatedButton(
                            onPressed: createFoodListing,
                            child: const Text('Create Listing'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
