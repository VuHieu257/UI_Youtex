import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import 'dart:core';
import 'package:ui_youtex/pages/screens/home/home.dart';
import 'package:ui_youtex/pages/screens/member_Vip/free_trail.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_packagePayment.dart';
import 'package:ui_youtex/pages/screens/message/chat/chat_screen.dart';
import 'package:ui_youtex/pages/screens/message/message.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen%20copy.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_shop_product.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/RegisterScreen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/forgotPass_Screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassDone_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassOtp_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPass_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/welcome.dart';
import 'package:ui_youtex/pages/widget_small/bottom_navigation/bottom_navigation.dart';

import 'core/themes/theme_data.dart';
import 'pages/splash/Welcome/Register/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCU66WlqitlSdBipwdwb_69uuRnJNupI0s',
          appId: '1:57983356211:android:5fd331cd4ef5361fea4246',
          messagingSenderId: '57983356211',
          projectId: 'mangxahoi-sotavn',
          storageBucket: "mangxahoi-sotavn.appspot.com"
      )) :
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyAppThemes.lightTheme,
      debugShowCheckedModeBanner: false,

      // home: HomePage(),
      home: const WelcomeApp(),
      // home: const CustomNavBar(),
      // home: const MessagesScreen(),
      // home: const GridGallery(),
      // home: CustomBackground(),
      // home: MembershipPaymentScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomePage(),
        '/memberVip': (context) => const FreeTrialTimeline(),
        '/CustomNavBar': (context) => const CustomNavBar(),
        '/Forgot': (context) => const ForgotScreen(),
        '/OTP': (context) => const OTPScreen(),
        '/Reset': (context) => const ResetpassScreen(),
        '/Resetpass': (context) => const ResetpassdoneScreen(),
        '/MembershipPaymentScreen': (context) => const MembershipPaymentScreen(),
        '/PaymentMethodScreen': (context) => const PaymentMethodScreen(),
        '/PaymentMethodPayScreen': (context) => const PaymentMethodPayScreen(),
        '/product_management': (context) => const ProductManagementScreen(),
      },
    );
  }
}

// class GridGallery extends StatefulWidget {
//   final ScrollController? scrollCtr;
//
//   const GridGallery({super.key, this.scrollCtr});
//
//   @override
//   _GridGalleryState createState() => _GridGalleryState();
// }
//
// class _GridGalleryState extends State<GridGallery> {
//   List<Widget> _mediaList = [];
//   List<Widget> _confirmedImages = []; // List to display confirmed images
//   int currentPage = 0;
//   int? lastPage;
//   Set<AssetEntity> _selectedImages = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchNewMedia();
//   }
//
//   _handleScrollEvent(ScrollNotification scroll) {
//     if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
//       if (currentPage != lastPage) {
//         _fetchNewMedia();
//       }
//     }
//   }
//
//   _fetchNewMedia() async {
//     lastPage = currentPage;
//     final PermissionState _ps = await PhotoManager.requestPermissionExtend();
//
//     if (_ps.isAuth) {
//       List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
//         type: RequestType.image,
//         onlyAll: true,
//       );
//
//       if (albums.isNotEmpty) {
//         List<AssetEntity> media = await albums[0].getAssetListPaged(
//           page: currentPage,
//           size: 60,
//         );
//
//         List<Widget> temp = media.map((asset) {
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 if (_selectedImages.contains(asset)) {
//                   _selectedImages.remove(asset);
//                 } else {
//                   _selectedImages.add(asset);
//                 }
//               });
//             },
//             child: Stack(
//               children: [
//                 FutureBuilder<Uint8List?>(
//                   future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
//                       return Positioned.fill(
//                         child: Image.memory(
//                           snapshot.data!,
//                           fit: BoxFit.cover,
//                         ),
//                       );
//                     }
//                     return Container(color: Colors.grey);
//                   },
//                 ),
//                 // Align(
//                 //   alignment: Alignment.topRight,
//                 //   child: Checkbox(
//                 //     value: _selectedImages.contains(asset),
//                 //     onChanged: (isSelected) {
//                 //       setState(() {
//                 //         if (isSelected == true) {
//                 //           _selectedImages.add(asset);
//                 //         } else {
//                 //           _selectedImages.remove(asset);
//                 //         }
//                 //       });
//                 //     },
//                 //     checkColor: Colors.white,
//                 //     activeColor: Colors.blue,
//                 //   ),
//                 // ),
//                 Align(
//                     alignment: Alignment.topRight,
//                   child: Container(
//                     margin:const EdgeInsets.only(top: 10,right: 10),
//                     height: 20,
//                     width: 20,
//                     decoration:BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList();
//
//         setState(() {
//           _mediaList.addAll(temp);
//           currentPage++;
//         });
//       }
//     } else {
//       PhotoManager.openSetting();
//     }
//   }
//
//   // Confirm and display selected images on the main screen
//   void _confirmSelection() async {
//     List<Widget> selectedWidgets = _selectedImages.map((asset) {
//       return FutureBuilder<Uint8List?>(
//         future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
//             return Image.memory(snapshot.data!, fit: BoxFit.cover);
//           }
//           return Container(color: Colors.grey);
//         },
//       );
//     }).toList();
//
//     setState(() {
//       _confirmedImages = selectedWidgets;
//       _selectedImages.clear(); // Clear selection after confirmation
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           // Display confirmed images at the top of the screen
//           if (_confirmedImages.isNotEmpty)
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 children: _confirmedImages,
//               ),
//             ),
//           Expanded(
//             child: NotificationListener<ScrollNotification>(
//               onNotification: (ScrollNotification scroll) {
//                 _handleScrollEvent(scroll);
//                 return false;
//               },
//               child: GridView.builder(
//                 controller: widget.scrollCtr,
//                 itemCount: _mediaList.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//                 itemBuilder: (context, index) {
//                   return _mediaList[index];
//                 },
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _selectedImages.isNotEmpty ? _confirmSelection : null,
//             child: const Text('Confirm Selection'),
//           ),
//         ],
//       ),
//     );
//   }
// }

class GridGallery extends StatefulWidget {
  final ScrollController? scrollCtr;

  const GridGallery({super.key, this.scrollCtr});

  @override
  _GridGalleryState createState() => _GridGalleryState();
}

class _GridGalleryState extends State<GridGallery> {
  List<AssetEntity> _mediaList = []; // Store images directly
  List<Widget> _confirmedImages = []; // Confirmed images for display
  int currentPage = 0;
  int? lastPage;
  Set<AssetEntity> _selectedImages = {};

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();

    if (_ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      if (albums.isNotEmpty) {
        List<AssetEntity> media = await albums[0].getAssetListPaged(
          page: currentPage,
          size: 60,
        );

        setState(() {
          _mediaList.addAll(media); // Add new images to the list
          currentPage++;
        });
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  // Confirm selected images to display on main screen
  void _confirmSelection() async {
    List<Widget> selectedWidgets = _selectedImages.map((asset) {
      return FutureBuilder<Uint8List?>(
        future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
            return Image.memory(snapshot.data!, fit: BoxFit.cover);
          }
          return Container(color: Colors.grey);
        },
      );
    }).toList();

    setState(() {
      _confirmedImages = selectedWidgets;
      _selectedImages.clear(); // Clear selection after confirmation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Display confirmed images at the top
          if (_confirmedImages.isNotEmpty)
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                children: _confirmedImages,
              ),
            ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scroll) {
                _handleScrollEvent(scroll);
                return false;
              },
              child: GridView.builder(
                controller: widget.scrollCtr,
                itemCount: _mediaList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
                  AssetEntity asset = _mediaList[index];
                  bool isSelected = _selectedImages.contains(asset);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedImages.remove(asset);
                        } else {
                          _selectedImages.add(asset);
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        FutureBuilder<Uint8List?>(
                          future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                              return Positioned.fill(
                                child: Image.memory(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                            return Container(color: Colors.grey);
                          },
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? Colors.blue : null,
                              border: Border.all(
                                width: 2.5,
                                color: Colors.white
                              )
                            ),
                            child: isSelected
                                ? const Icon(Icons.check, color: Colors.white, size: 16)
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _selectedImages.isNotEmpty ? _confirmSelection : null,
            child: const Text('Confirm Selection'),
          ),
        ],
      ),
    );
  }
}

class ChatListScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // String currentUserId = _auth.currentUser!.uid;
    void createNewChat(String currentUserId, String otherUserId) async {
      final chatDocRef = _firestore.collection('chats').doc();

      await chatDocRef.set({
        'participants': [currentUserId, otherUserId],
        'lastMessage': '',
        'lastTimestamp': FieldValue.serverTimestamp(),
      });

      // Điều hướng tới màn hình chat
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            chatId: chatDocRef.id,
            receiverId: otherUserId,
            receiverName: 'Tên của người nhận',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Các cuộc trò chuyện"),
        actions: [
          InkWell(onTap: () {
            createNewChat("user1", "user2");
          },child: const Icon(Icons.add_box_outlined))
        ],
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('chats')
            // .where('participants', arrayContains: currentUserId)
            .where('participants', arrayContains: "user1")
            .orderBy('lastTimestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var chatDocs = snapshot.data!.docs;

          if (chatDocs.isEmpty) {
            return const Center(child: Text("Không có cuộc trò chuyện nào"));
          }

          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              var chat = chatDocs[index];
              var participants = chat['participants'] as List;

              // Lấy ra ID của người nhận (người không phải là user hiện tại)
              // String otherUserId = participants.firstWhere((id) => id != currentUserId);
              String otherUserId = participants.firstWhere((id) => id != "user1");

              return FutureBuilder(
                future: _firestore.collection('users').doc("user2").get(), // Lấy thông tin người nhận
                builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const ListTile(title: Text("Loading..."));
                  }

                  var userData = userSnapshot.data!.data() as Map<String, dynamic>;
                  String otherUserName = userData['name'];

                  return ListTile(
                    title: Text(otherUserName),
                    subtitle: Text(chat['lastMessage']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            chatId: chat.id,
                            receiverId: otherUserId,
                            receiverName: otherUserName,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
// class ChatScreen extends StatefulWidget {
//   final String chatId;
//   final String receiverId;
//   final String receiverName;
//
//   ChatScreen({
//     required this.chatId,
//     required this.receiverId,
//     required this.receiverName,
//   });
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   void _sendMessage() async {
//     String message = _messageController.text.trim();
//     if (message.isEmpty) return;
//
//     // String currentUserId = _auth.currentUser!.uid;
//     String currentUserId = "user1";
//
//     var messageRef = _firestore
//         .collection('chats')
//         .doc(widget.chatId)
//         .collection('messages')
//         .doc();
//
//     await messageRef.set({
//       'senderId': currentUserId,
//       'receiverId': widget.receiverId,
//       'message': message,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     // Cập nhật tin nhắn cuối cùng và thời gian trong collection chats
//     await _firestore.collection('chats').doc(widget.chatId).update({
//       'lastMessage': message,
//       'lastTimestamp': FieldValue.serverTimestamp(),
//     });
//
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.receiverName),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: _firestore
//                   .collection('chats')
//                   .doc(widget.chatId)
//                   .collection('messages')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 var messages = snapshot.data!.docs;
//
//                 return ListView.builder(
//                   reverse: true, // Để tin nhắn mới nhất ở dưới cùng
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     var messageData = messages[index];
//                     // bool isMe = messageData['senderId'] == _auth.currentUser!.uid;
//                     bool isMe = messageData['senderId'] == "user1";
//
//                     return Align(
//                       alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: isMe ? Colors.blue : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           messageData['message'],
//                           style: TextStyle(
//                             color: isMe ? Colors.white : Colors.black,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           _buildBottomInputArea(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomInputArea() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade200,
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.add_reaction_outlined, color: Colors.black54),
//             onPressed: () {
//               // Handle reactions
//             },
//           ),
//           SizedBox(width: 8.0),
//           Expanded(
//             child: TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Tin nhắn',
//                 border: InputBorder.none,
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _messageController.text=value;
//                 });
//               },
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send, color:_messageController.text.isEmpty?Colors.grey :Colors.blue),
//             onPressed: _messageController.text.isEmpty?null:_sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
// }