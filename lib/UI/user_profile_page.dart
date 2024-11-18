import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class UserProfileController extends GetxController {
  var emailNotifications = false.obs;
  var smsNotifications = false.obs;
  var userName = 'John D'.obs;
  var userEmail = 'john.d@example.com'.obs;
  var userAddress = 'Kigali, Rwanda'.obs;
  var profileImagePath = ''.obs;

  final RxList<Map<String, dynamic>> pastRequests = [
    {'item': 'Fresh Apples - 5 kg', 'date': 'Oct 10, 2024'},
    {'item': 'Assorted Vegetables - 3 kg', 'date': 'Oct 5, 2024'},
  ].obs;
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
              Obx(() => _buildTextField('Name', controller.userName.value)),
              Obx(() => _buildTextField('Contact Info', controller.userEmail.value)),
              Obx(() => _buildTextField('Address', controller.userAddress.value)),
              const SizedBox(height: 24),

              // Past Food Requests Section
              const Text(
                'Past Food Request',
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
                    (value) => controller.emailNotifications.value = value ?? false,
              )),
              Obx(() => _buildCheckboxTile(
                'SMS Notifications',
                controller.smsNotifications.value,
                    (value) => controller.smsNotifications.value = value ?? false,
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
                            onPressed: () {
                              // TODO: Implement logout
                              Get.back();
                              Get.back(); // Return to previous screen after logout
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

  Widget _buildTextField(String label, String value) {
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
            controller: TextEditingController(text: value),
            readOnly: true,
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
      ValueChanged<bool?> onChanged,
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