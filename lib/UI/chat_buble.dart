import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  final String message;
  final bool isCurrentUser; // Flag to check if it's the current user's message

  const ChatBuble({
    super.key,
    required this.message,
    required this.isCurrentUser, // Accept the flag to adjust the style
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5), // Space between messages
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isCurrentUser
            ? Colors.green
            : Colors.grey.shade300, // Different colors
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: isCurrentUser
              ? Colors.white
              : Colors.black, // Text color depending on sender
        ),
      ),
    );
  }
}
