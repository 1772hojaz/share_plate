import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //instance for firebase auth and fireStore

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sending messages
  Future<void> sendMessage(String receievrId, String message) async {
    //getting user information
    //creating a new message
    //constructing a chat room id for the current user is and receiver id (sort the data for uniqueness)
    //adding the message to our data base
  }

  //Receive message
}
