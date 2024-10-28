import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe
              ? Colors.lightBlueAccent.shade100.withOpacity(0.5)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: context.width * 0.65,
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}