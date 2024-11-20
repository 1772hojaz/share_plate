import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxController {
  static FirebaseService get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final Rx<User?> currentUser = Rx<User?>(null);

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
}