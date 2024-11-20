import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receverId;
  final Timestamp timestamp;

  Message(this.receverId, this.timestamp,
      {required this.senderId, required this.senderEmail});

  //coveting the data into a map

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'Timestamp': timestamp,
    };
  }
}
