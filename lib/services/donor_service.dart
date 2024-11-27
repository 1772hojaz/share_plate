import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/donor.dart';

class DonorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _donationsCollection =
  FirebaseFirestore.instance.collection('donations');

  // CREATE - Add a new food donation
  Future<void> createFoodDonation(DonorFood donation) async {
    try {
      String userId = _auth.currentUser?.uid ?? '';
      if (userId.isEmpty) {
        throw Exception('User not authenticated');
      }

      await _donationsCollection.add({
        ...donation.toJson(),
        'userId': userId,
        'created_at': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(
        msg: 'Food donation posted successfully',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error creating donation: ${e.toString()}',
        backgroundColor: Colors.red,
      );
      throw e;
    }
  }

  // READ - Get all food donations
  Stream<List<DonorFood>> getAllDonations() {
    return _donationsCollection
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return DonorFood.fromJson(data);
      }).toList();
    });
  }

  // READ - Get donations by user
  Stream<List<DonorFood>> getUserDonations() {
    String userId = _auth.currentUser?.uid ?? '';
    if (userId.isEmpty) return Stream.value([]);

    return _donationsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return DonorFood.fromJson(data);
      }).toList();
    });
  }

  // READ - Get single donation
  Future<DonorFood?> getDonation(String donationId) async {
    try {
      DocumentSnapshot doc = await _donationsCollection.doc(donationId).get();
      if (doc.exists) {
        return DonorFood.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error fetching donation: ${e.toString()}',
        backgroundColor: Colors.red,
      );
      return null;
    }
  }

  // UPDATE - Update a food donation
  Future<void> updateFoodDonation(String donationId, DonorFood updatedDonation) async {
    try {
      String userId = _auth.currentUser?.uid ?? '';
      DocumentSnapshot donation = await _donationsCollection.doc(donationId).get();

      if (!donation.exists) {
        throw Exception('Donation not found');
      }

      Map<String, dynamic> data = donation.data() as Map<String, dynamic>;
      if (data['userId'] != userId) {
        throw Exception('Not authorized to update this donation');
      }

      await _donationsCollection.doc(donationId).update(updatedDonation.toJson());

      Fluttertoast.showToast(
        msg: 'Donation updated successfully',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error updating donation: ${e.toString()}',
        backgroundColor: Colors.red,
      );
      throw e;
    }
  }

  // DELETE - Delete a food donation
  Future<void> deleteFoodDonation(String donationId) async {
    try {
      String userId = _auth.currentUser?.uid ?? '';
      DocumentSnapshot donation = await _donationsCollection.doc(donationId).get();

      if (!donation.exists) {
        throw Exception('Donation not found');
      }

      Map<String, dynamic> data = donation.data() as Map<String, dynamic>;
      if (data['userId'] != userId) {
        throw Exception('Not authorized to delete this donation');
      }

      await _donationsCollection.doc(donationId).delete();

      Fluttertoast.showToast(
        msg: 'Donation deleted successfully',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error deleting donation: ${e.toString()}',
        backgroundColor: Colors.red,
      );
      throw e;
    }
  }
}