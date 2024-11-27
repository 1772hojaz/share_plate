import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:share_plate/models/messages.dart';

class ChatService extends ChangeNotifier {
  //instance for firebase auth and fireStore

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sending messages
  Future<void> sendMessage(String receieverId, String message) async {
    //getting user information
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //creating a new message
    Messages newMessage = Messages(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receieverId,
      timestamp: timestamp,
      message: message,
    );
    //constructing a chat room id for the current user is and receiver id (sort the data for uniqueness)
    List<String> ids = [currentUserId, receieverId];
    ids.sort();

    String chatRoomId = ids.join("_");
    //adding the message to our data base

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //Receive message
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // Sort userIds to create a consistent chat room ID
    List<String> ids = [userId, otherUserId];
    ids.sort();

    // Create chat room ID from sorted user IDs
    String chatRoomId = ids.join('_');

    // Return the stream of messages from the chat room
    return _firestore
        .collection('chat_rooms') // Collection of chat rooms
        .doc(chatRoomId) // Chat room specific to the two users
        .collection('messages') // Messages subcollection within the chat room
        .orderBy('timestamp',
            descending: true) // Order messages by timestamp (ascending)
        .snapshots(); // Listen to the changes
  }
}
