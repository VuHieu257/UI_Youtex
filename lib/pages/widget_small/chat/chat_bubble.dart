import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final List<dynamic> img;
  final bool isMe;
  final bool isPlaying;
  final String urlVoice;
  final void Function()? onPressed;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.isMe,
      required this.img,
      required this.isPlaying,
      this.onPressed,
      required this.urlVoice});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: message.isNotEmpty,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.lightBlueAccent.shade200.withOpacity(0.5)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Visibility(
            visible: img.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Wrap(
                spacing: 2.0,
                runSpacing: 2.0,
                children: List.generate(
                  img.length,
                  (imgIndex) => Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(img[imgIndex]),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: urlVoice.isNotEmpty,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(isPlaying ? "Stop" : "Play"),
            ),
          ),
        ],
      ),
    );
  }
}
