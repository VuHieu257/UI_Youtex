import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// class ChatBubble extends StatelessWidget {
//   final String message;
//   final List<dynamic> img;
//   final bool isMe;
//   final bool isPlaying;
//   final String urlVoice;
//   final void Function()? onPressed;
//
//   const ChatBubble(
//       {super.key,
//       required this.message,
//       required this.isMe,
//       required this.img,
//       required this.isPlaying,
//       this.onPressed,
//       required this.urlVoice});
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Column(
//         crossAxisAlignment:
//             isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           Visibility(
//             visible: message.isNotEmpty,
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: isMe
//                     ? Colors.lightBlueAccent.shade200.withOpacity(0.5)
//                     : Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 message,
//                 style: const TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//           Visibility(
//             visible: img.isNotEmpty,
//             // child: Padding(
//             //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//             //   child: Wrap(
//             //     spacing: 2.0,
//             //     runSpacing: 2.0,
//             //     children: List.generate(
//             //       img.length,
//             //       (imgIndex) => Container(
//             //         width: 150,
//             //         height: 150,
//             //         decoration: BoxDecoration(
//             //             color: Colors.grey.shade200,
//             //             borderRadius: BorderRadius.circular(10),
//             //             image: DecorationImage(
//             //               image: NetworkImage(img[imgIndex]),
//             //               fit: BoxFit.cover,
//             //             )),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             child: FutureBuilder<List<String>>(
//               future: fetchImageUrls(img),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Lỗi tải ảnh!'));
//                 }
//                 if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text('Không có ảnh để hiển thị!'));
//                 }
//
//                 List<String> urls = snapshot.data!;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                   child: Wrap(
//                     spacing: 2.0,
//                     runSpacing: 2.0,
//                     children: List.generate(
//                       urls.length,
//                           (imgIndex) => Container(
//                         width: 150,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(10),
//                           image: DecorationImage(
//                             image: NetworkImage(urls[imgIndex]),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Visibility(
//             visible: urlVoice.isNotEmpty,
//             child: ElevatedButton(
//               onPressed: onPressed,
//               child: Text(isPlaying ? "Stop" : "Play"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Future<List<String>> fetchImageUrls(List<dynamic> ids) async {
//     final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('chat_images');
//     List<String> imageUrls = [];
//
//     for (String id in ids) {
//       final snapshot = await databaseRef.child(id).get();
//       if (snapshot.exists) {
//         final data = snapshot.value as Map<dynamic, dynamic>;
//         if (data.containsKey("base64")) {
//           // Chuyển base64 sang URL hoặc Uint8List
//           imageUrls.add(data["base64"]); // Hoặc lấy một trường khác chứa URL
//         }
//       }
//     }
//     return imageUrls;
//   }
// }

class ChatBubble extends StatelessWidget {
  final String message;
  final List<dynamic> img;
  final bool isMe;
  final bool isPlaying;
  final String urlVoice;
  final void Function()? onPressed;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.img,
    required this.isPlaying,
    this.onPressed,
    required this.urlVoice,
  });

  // Hàm để lấy URL hình ảnh từ Firebase
  Future<List<String>> fetchImageUrls(List<dynamic> imageIds) async {
    final databaseRef = FirebaseDatabase.instance.ref('chat_images');
    List<String> imageUrls = [];

    for (var imageId in imageIds) {
      try {
        final snapshot = await databaseRef.child(imageId).get();
        if (snapshot.exists) {
          final imageData = snapshot.value as Map<dynamic, dynamic>;
          final imageUrl = imageData['base64'] ?? ''; // Lấy URL từ Firebase
          if (imageUrl.isNotEmpty) {
            imageUrls.add(imageUrl);
          }
        }
      } catch (e) {
        print('Lỗi khi tải ảnh: $e');
      }
    }
    return imageUrls;
  }

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
            child: FutureBuilder<List<String>>(
              future: fetchImageUrls(img),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }
                List<String> urls = snapshot.data!;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Wrap(
                    spacing: 2.0,
                    runSpacing: 2.0,
                    children: List.generate(
                      urls.length,
                      (imgIndex) => Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: MemoryImage(base64Decode(urls[imgIndex])),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
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
