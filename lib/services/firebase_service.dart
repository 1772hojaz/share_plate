// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:cloudinary_url_gen/transformation/resize/resize.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';

class FirebaseService extends GetxController {
  static FirebaseService get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final Rx<User?> currentUser = Rx<User?>(null);

  var cloudinary = Cloudinary.fromStringUrl(
      'cloudinary://915753183111878:ME5yxpR1Q07qPuteE4WQ0JOwI3s@ dz5rslegb');
  @override
  void onInit() {
    super.onInit();
    currentUser.bindStream(_auth.authStateChanges());
  }

  bool get isLoggedIn => currentUser.value != null;

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed('/signin');
  }

  Future<DocumentSnapshot?> getUserData() async {
    if (!isLoggedIn) return null;
    return await _db.collection('users').doc(currentUser.value!.uid).get();
  }

  Future<void> updateUserProfile({
    String? name,
    String? email,
    String? address,
    Map<String, dynamic>? preferences,
  }) async {
    if (!isLoggedIn) return;

    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (email != null) updates['email'] = email;
    if (address != null) updates['address'] = address;
    if (preferences != null) updates['preferences'] = preferences;

    await _db.collection('users').doc(currentUser.value!.uid).update(updates);
  }

  /// Uploads an image to Cloudinary and returns the download URL
  Future<String?> uploadToCloudinary(File image) async {
    try {
      if (!isLoggedIn) return null;

      final uploadResponse = await cloudinary.uploader().upload(image.path,
          params: UploadParams(
              publicId: 'food_image_${DateTime.now().millisecondsSinceEpoch}',
              uniqueFilename: false,
              overwrite: true));

      if (uploadResponse?.data?.secureUrl != null) {
        print(
            "Image uploaded successfully: ${uploadResponse?.data?.secureUrl}");
        return uploadResponse?.data?.secureUrl;
      } else {
        // print("Upload failed: ${uploadResponse?.data?.error}");
        return null;
      }
    } catch (e) {
      print('Error uploading to Cloudinary: $e');
      return null;
    }
  }

  /// Adds a food listing to Firestore, including an optional image URL from Cloudinary
  Future<void> addFoodListing({
    required String description,
    required int quantity,
    required String pickupLocation,
    File? foodImage,
  }) async {
    if (!isLoggedIn) return;

    String? imageUrl;
    if (foodImage != null) {
      imageUrl = await uploadToCloudinary(foodImage);
    }

    await _db.collection('food_items').add({
      'donor_id': currentUser.value!.uid,
      'description': description,
      'quantity': quantity,
      'pickup_location': pickupLocation,
      'image_url': imageUrl,
      'status': 'available',
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
