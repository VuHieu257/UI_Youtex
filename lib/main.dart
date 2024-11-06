import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import 'package:ui_youtex/bloc/address_bloc/address_bloc.dart';
import 'package:ui_youtex/bloc/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/friend_list_screen/friend_list_screen.dart';
import 'dart:core';
import 'package:ui_youtex/pages/screens/home/home.dart';
import 'package:ui_youtex/pages/screens/home/product/adress/adress_screen.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_product.dart';
import 'package:ui_youtex/pages/screens/member_Vip/free_trail.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_packagePayment.dart';
import 'package:ui_youtex/pages/screens/message/chat/chat_screen.dart';
import 'package:ui_youtex/pages/screens/message/friend_list_scrren.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen%20copy.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/RegisterScreen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/forgotPass_Screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassDone_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPassOtp_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/resetPass/resetPass_screen.dart';
import 'package:ui_youtex/pages/splash/Welcome/welcome.dart';
import 'package:ui_youtex/pages/widget_small/bottom_navigation/bottom_navigation.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/constants.dart';
import 'package:ui_youtex/util/token_manager.dart';
import 'bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/register_bloc/register_bloc.dart';
import 'bloc/search_user_bloc/fetch_user_by_phone_bloc.dart';
import 'bloc/user_profile_bloc/user_profile_bloc.dart';
import 'core/assets.dart';
import 'core/colors/color.dart';
import 'core/themes/theme_data.dart';
import 'pages/splash/Welcome/Register/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCU66WlqitlSdBipwdwb_69uuRnJNupI0s',
              appId: '1:57983356211:android:5fd331cd4ef5361fea4246',
              messagingSenderId: '57983356211',
              projectId: 'mangxahoi-sotavn',
              storageBucket: "mangxahoi-sotavn.appspot.com"))
      : await Firebase.initializeApp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => LoginBloc(),
    ),
    BlocProvider(
      create: (context) => RegisterBloc(),
    ),
    BlocProvider(
      create: (context) => ForgotPasswordBloc(),
    ),
    BlocProvider(
      create: (context) => EditProfileBloc(),
    ),
    BlocProvider(
      create: (context) => AddressBloc(),
    ),
    BlocProvider(
      create: (context) => FetchUserByPhoneBloc(),
    ),
    BlocProvider(
      create: (context) => UserProfileBloc()..add(FetchProfileEvent()),
      child: const CustomNavBar(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyAppThemes.lightTheme,
      debugShowCheckedModeBanner: false,

      home: const WelcomeApp(),
      // home: ChatListScreen(),
      // home: const CustomNavBar(),
      // home: const UserScreen("0812507355"),
      // home: const FriendListScreen(),
      // home: const SearchUserByPhoneScreen(),
      // home: const FriendListScreen(),
      // home: const FriendsList(userId: '0812507355',),
      // home: const MessagesScreen(),
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
        '/MembershipPaymentScreen': (context) =>
            const MembershipPaymentScreen(),
        '/PaymentMethodScreen': (context) => const PaymentMethodScreen(),
        '/PaymentMethodPayScreen': (context) => const PaymentMethodPayScreen(),
        '/product_management': (context) => const ProductManagementScreen(),
      },
    );
  }
}

class SearchUserByPhoneScreen extends StatefulWidget {
  const SearchUserByPhoneScreen({super.key});

  @override
  _SearchUserByPhoneScreenState createState() =>
      _SearchUserByPhoneScreenState();
}

class _SearchUserByPhoneScreenState extends State<SearchUserByPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search User by Phone'),
      ),
      body: BlocBuilder<FetchUserByPhoneBloc, FetchUserByPhoneState>(
          builder: (context, state) {
        if (state is UserLoading) {
          return const CircularProgressIndicator();
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          hintText: 'Tìm kiếm bạn bè',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final phone = _phoneController.text;
                        if (phone.isNotEmpty) {
                          // Dispatch the event to the bloc
                          context
                              .read<FetchUserByPhoneBloc>()
                              .add(FetchUserByPhone(phone));
                          FocusScope.of(context).unfocus(); // Hide the keyboard
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            borderRadius: BorderRadius.circular(18),
                            color: const Color(0xffF3F3F3)),
                        child: const Icon(Icons.done_all),
                      ),
                    ),
                  ),
                ],
              ),
              if (state is UserLoaded) ...{
                FriendCard(id:state.id,name: state.name,img: "${state.img}",),
              }
            ],
          ),
        );
      }),
    );
  }
}
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addFriend(String userId, String friendId, String name, String? imgUrl) async {
  try {
    await _firestore.collection('users').doc(userId).collection('friends').doc(friendId).set({
      'id': friendId,
      'name': name,
      'image': imgUrl,
      'addedAt': FieldValue.serverTimestamp(),
    });
    if (kDebugMode) {
      print("Friend added successfully");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Failed to add friend: $e");
    }
  }
}
void createNewChat(BuildContext context,String currentUserId, String otherUserId) async {
  final chatDocRef = _firestore.collection('chats').doc();

  await chatDocRef.set({
    'participants': [currentUserId, otherUserId],
    'lastMessage': '',
    'lastTimestamp': FieldValue.serverTimestamp(),
  });

  // Điều hướng tới màn hình chat
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => ChatScreen(
  //       chatId: chatDocRef.id,
  //       receiverId: otherUserId,
  //       receiverName: 'Tên của người nhận',
  //     ),
  //   ),
  // );
}
class FriendCard extends StatelessWidget {
  final String name;
  final String img;
  final String id;
  const FriendCard({super.key, required this.name, required this.img, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: const Color(0xffF3F3F3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: context.width * 0.15,
                width: context.width * 0.15,
                decoration:  BoxDecoration(
                  borderRadius:const BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                      image:img.isEmpty||img=="null"?const AssetImage(Asset.bgImageAvatar):NetworkImage("${NetworkConstants.urlImage}/storage/$img")as ImageProvider,
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Member ID: $id',
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => createNewChat(context,"0812507355","0812507356",),
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4),
                    ],
                    color: Styles.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'Nhắn tin',
                    style: context.theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  addFriend("0812507355","0812507356",name,img);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4),
                    ],
                    color: const Color(0xffFF6B6B),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'Kết bạn',
                    style: context.theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FriendsList extends StatelessWidget {
  final String userId;

  const FriendsList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: getFriends(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          final friends = snapshot.data;

          if (friends == null || friends.isEmpty) {
            return const Text("No friends added yet.");
          }

          return ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friend = friends[index];
              return ListTile(
                leading: friend['image'] != null
                    ? Image.network(friend['image'], width: 50, height: 50)
                    : const Icon(Icons.person, size: 50),
                title: Text(friend['name'] ?? 'Unknown'),
                subtitle: Text(friend['addedAt'] != null
                    ? 'Added on ${friend['addedAt'].toDate()}'
                    : 'Date not available'),
              );
            },
          );
        },
      ),
    );
  }

  Stream<List<Map<String, dynamic>>> getFriends(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('friends')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => doc.data())
        .toList());
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
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ChatScreen(
      //       chatId: chatDocRef.id,
      //       receiverId: otherUserId,
      //       receiverName: 'Tên của người nhận',
      //     ),
      //   ),
      // );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Các cuộc trò chuyện"),
        actions: [
          InkWell(
              onTap: () {
                createNewChat("user1", "user2");
              },
              child: const Icon(Icons.add_box_outlined))
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
              String otherUserId =
                  participants.firstWhere((id) => id != "user1");

              return FutureBuilder(
                future: _firestore.collection('users').doc("user2").get(),
                // Lấy thông tin người nhận
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const ListTile(title: Text("Loading..."));
                  }

                  var userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  String otherUserName = userData['name'];

                  return ListTile(
                    title: Text(otherUserName),
                    subtitle: Text(chat['lastMessage']),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ChatScreen(
                      //       chatId: chat.id,
                      //       receiverId: otherUserId,
                      //       receiverName: otherUserName,
                      //     ),
                      //   ),
                      // );
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
// class AddressScreen extends StatelessWidget {
//   const AddressScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Address List')),
//       body: BlocProvider(
//         create: (context) => AddressBloc()..add(FetchAddresses()),
//         child: BlocBuilder<AddressBloc, AddressState>(
//           builder: (context, state) {
//             if (state is AddressLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is AddressLoaded) {
//               return ListView.builder(
//                 itemCount: state.addresses.length,
//                 itemBuilder: (context, index) {
//                   final address = state.addresses[index];
//                   return ListTile(
//                     title: Text(address.name),
//                     subtitle: Text(address.address),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () {
//
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             context
//                                 .read<AddressBloc>()
//                                 .add(DeleteAddress(address.id));
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             } else if (state is AddressError) {
//               return Center(child: Text(state.message));
//             }
//             return const Center(child: Text('No addresses found.'));
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

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
  final List<AssetEntity> _mediaList = []; // Store images directly
  List<Widget> _confirmedImages = []; // Confirmed images for display
  int currentPage = 0;
  int? lastPage;
  final Set<AssetEntity> _selectedImages = {};

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
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    if (ps.isAuth) {
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
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
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
                          future: asset.thumbnailDataWithSize(
                              const ThumbnailSize(200, 200)),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data != null) {
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
                                    width: 2.5, color: Colors.white)),
                            child: isSelected
                                ? const Icon(Icons.check,
                                    color: Colors.white, size: 16)
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
