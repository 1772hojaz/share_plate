import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import '../services/firebase_service.dart';

class UserProfileController extends GetxController {
  final firebaseService = Get.find<FirebaseService>();

  var emailNotifications = false.obs;
  var smsNotifications = false.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userAddress = ''.obs;
  var profileImagePath = ''.obs;
  var isEditing = false.obs;

  // Text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final RxList<Map<String, dynamic>> pastRequests = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
    loadPastRequests();
  }

  Future<void> loadUserProfile() async {
    try {
      final userData = await firebaseService.getUserData();
      if (userData != null && userData.exists) {
        final data = userData.data() as Map<String, dynamic>;
        userName.value = data['name'] ?? '';
        userEmail.value = data['email'] ?? '';
        userAddress.value = data['address'] ?? '';
        emailNotifications.value = data['preferences']?['emailNotifications'] ?? false;
        smsNotifications.value = data['preferences']?['smsNotifications'] ?? false;
        profileImagePath.value = data['profileImage'] ?? '';

        // Update text controllers
        nameController.text = userName.value;
        emailController.text = userEmail.value;
        addressController.text = userAddress.value;
      }
    } catch (e) {
      print('Error loading user profile: $e');
      Get.snackbar(
        'Error',
        'Failed to load profile',
        backgroundColor: Colors.red[100],
      );
    }
  }

  Future<void> loadPastRequests() async {
    try {
      final requests = await FirebaseFirestore.instance
          .collection('requests')
          .where('recipient_id', isEqualTo: firebaseService.currentUser.value?.uid)
          .orderBy('created_at', descending: true)
          .get();

      pastRequests.value = requests.docs.map((doc) {
        final data = doc.data();
        return {
          'item': data['description'] ?? '',
          'date': _formatDate(data['created_at'] as Timestamp),
        };
      }).toList();
    } catch (e) {
      print('Error loading past requests: $e');
    }
  }

  String _formatDate(Timestamp timestamp) {
    final date = timestamp.toDate();
    return '${date.month}/${date.day}/${date.year}';
  }

  Future<void> updateProfile() async {
    try {
      await firebaseService.updateUserProfile(
        name: nameController.text,
        email: emailController.text,
        address: addressController.text,
        preferences: {
          'emailNotifications': emailNotifications.value,
          'smsNotifications': smsNotifications.value,
        },
      );

      // Update local values
      userName.value = nameController.text;
      userEmail.value = emailController.text;
      userAddress.value = addressController.text;

      isEditing.value = false;
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green[100],
      );
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar(
        'Error',
        'Failed to update profile',
        backgroundColor: Colors.red[100],
      );
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseService.signOut();
    } catch (e) {
      print('Error signing out: $e');
      Get.snackbar(
        'Error',
        'Failed to sign out',
        backgroundColor: Colors.red[100],
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.onClose();
  }
}

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Obx(() => TextButton(
            onPressed: () {
              if (controller.isEditing.value) {
                controller.updateProfile();
              } else {
                controller.isEditing.value = true;
              }
            },
            child: Text(
              controller.isEditing.value ? 'Save' : 'Edit',
              style: const TextStyle(color: Colors.blue),
            ),
          )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture Section
              Center(
                child: Column(
                  children: [
                    Obx(() => Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: controller.profileImagePath.value.isEmpty
                              ? const AssetImage('assets/default_profile.jpg')
                              : FileImage(File(controller.profileImagePath.value))
                          as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement profile picture change
                      },
                      child: const Text(
                        'Change Profile Picture',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Personal Details Section
              const Text(
                'Personal Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Name',
                controller.nameController,
                enabled: controller.isEditing.value,
              ),
              _buildTextField(
                'Email',
                controller.emailController,
                enabled: controller.isEditing.value,
              ),
              _buildTextField(
                'Address',
                controller.addressController,
                enabled: controller.isEditing.value,
              ),
              const SizedBox(height: 24),

              // Past Food Requests Section
              const Text(
                'Past Food Requests',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => Column(
                children: controller.pastRequests.map((request) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          request['item'] as String,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          request['date'] as String,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )),
              const SizedBox(height: 24),

              // Notification Preferences Section
              const Text(
                'Notification Preferences',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => _buildCheckboxTile(
                'Email Notifications',
                controller.emailNotifications.value,
                controller.isEditing.value
                    ? (value) => controller.emailNotifications.value = value ?? false
                    : null,
              )),
              Obx(() => _buildCheckboxTile(
                'SMS Notifications',
                controller.smsNotifications.value,
                controller.isEditing.value
                    ? (value) => controller.smsNotifications.value = value ?? false
                    : null,
              )),
              const SizedBox(height: 24),

              // Account Settings Section
              const Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Get.back();
                              await controller.signOut();
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool enabled = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile(
      String title,
      bool value,
      ValueChanged<bool?>? onChanged,
      ) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}