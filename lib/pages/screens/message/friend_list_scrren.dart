import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/oder_manager/oder_manager_screen.dart';

import '../../../bloc/search_user_bloc/fetch_user_by_phone_bloc.dart';
import 'chat/chat_screen.dart';

class FriendListScreen extends StatelessWidget {
  final String currentUserId;

  const FriendListScreen({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Styles.nearPrimary)),
        title: Column(
          children: [
            Center(
              child: Text(
                'Bạn bè',
                style: context.theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Styles.nearPrimary),
              ),
            ),
            Divider(
                indent: context.width * 0.15, endIndent: context.width * 0.15),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
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
                    child: const TextField(
                      decoration: InputDecoration(
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
                      showAddFriendDialog(context, currentUserId);
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
                      child: const Icon(Icons.group_add_outlined),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const FilterModal();
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4)
                          ],
                          borderRadius: BorderRadius.circular(18),
                          color: const Color(0xffF3F3F3)),
                      child: const Icon(Icons.filter_alt_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              // child: StreamBuilder<QuerySnapshot>(
              //   stream: FirebaseFirestore.instance
              //       .collection('friendRequests')
              //       // .where('receiverId', isEqualTo: "0332340187")
              //       .where('receiverId', isEqualTo: currentUserId)
              //       .snapshots(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              //       return const Text("No friend requests.");
              //     }
              //     final friends = snapshot.data!.docs;
              //     return ListView.builder(
              //       itemCount: friends.length,
              //       itemBuilder: (context, index) {
              //         final friend = friends[index];
              //         String friendRequestId = friend.id;
              //         return FriendCard(
              //           id: friend['receiverId'],
              //           name: friend['name'],
              //           img: friend['image'],
              //           isFriend: friend['status'],
              //           friendRequestId: friendRequestId,
              //         );
              //       },
              //     );
              //   },
              // ),
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('friendRequests')
                .where('receiverId', isEqualTo: currentUserId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('friendRequests')
                      .where('senderId', isEqualTo: currentUserId)
                      .snapshots(),
                  builder: (context, sentSnapshot) {
                    if (sentSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!sentSnapshot.hasData ||
                        sentSnapshot.data!.docs.isEmpty) {
                      return const Text("No friend requests sent or received.");
                    }

                    final sentFriends = sentSnapshot.data!.docs;
                    return ListView.builder(
                      itemCount: sentFriends.length,
                      itemBuilder: (context, index) {
                        final friend = sentFriends[index];
                        String friendRequestId = friend.id;
                        return FriendCard(
                          id:currentUserId ,
                          idOtherUser: friend['receiverId'],
                          name: friend['name'],
                          img: friend['image'],
                          isFriend: friend['status'],
                          status: "sender",
                          friendRequestId: friendRequestId,
                        );
                      },
                    );
                  },
                );
              }

              final friends = snapshot.data!.docs;
              return ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  String friendRequestId = friend.id;
                  return FriendCard(
                    id:currentUserId ,
                    idOtherUser: friend['receiverId'],
                    name: friend['name'],
                    img: friend['image'],
                    isFriend: friend['status'],
                    friendRequestId: friendRequestId,
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }

  Stream<List<Map<String, dynamic>>> getFriends(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('friends')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}

class FriendCard extends StatelessWidget {
  final String name;
  final String img;
  final String id;
  final bool? isRow;
  final String? isFriend;
  final String? idOtherUser;
  final String? status;
  final String? friendRequestId;

  const FriendCard(
      {super.key,
      required this.name,
      required this.img,
      required this.id,
      this.isRow = true,
      this.isFriend = "",
      this.idOtherUser = "",
      this.status = "",
      this.friendRequestId = ""});

  @override
  Widget build(BuildContext context) {
    return isRow ?? true
        ? Card(
            color: const Color(0xffF3F3F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: context.width * 0.15,
                    width: context.width * 0.15,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                          image: AssetImage(Asset.bgImageAvatar),
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
                    onTap: () => createNewChat(context,id,"$idOtherUser",name),
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
                      isFriend == "pending"
                          ? acceptFriendRequest("$friendRequestId", "$isFriend",
                              "$idOtherUser", name, img)
                          : showUnfollowDialog(context, "$isFriend",
                              "$idOtherUser", "$friendRequestId");
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
                        color: status == "sender"
                            ? Colors.grey
                            : isFriend == "pending"
                                ? Colors.green
                                : const Color(0xffFF6B6B),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        status == "sender"
                            ? "Chờ"
                            : isFriend == "pending"
                                ? "Chấp nhận"
                                : 'hủy kết bạn ',
                        style: context.theme.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Card(
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
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      image: DecorationImage(
                          image: AssetImage(Asset.bgImageAvatar),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style:
                                context.theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 70,
                            child: Text(
                              'Member ID: $idOtherUser',
                              style: context.theme.textTheme.titleMedium
                                  ?.copyWith(
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: idOtherUser != id,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => createNewChat(context,id,"$idOtherUser",name),
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
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Text(
                                  'Nhắn tin',
                                  style: context.theme.textTheme.titleSmall
                                      ?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                sendFriendRequest(
                                    id, "$idOtherUser", name, img);
                                Navigator.pop(context);
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
                                  color: Colors.greenAccent,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Text(
                                  'Kết bạn ',
                                  style: context.theme.textTheme.titleSmall
                                      ?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

void showAddFriendDialog(BuildContext context, String idUser) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final TextEditingController phoneController = TextEditingController();
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFDAF5FF),
                Color(0xFF3EB0FF),
                Color(0xFF1F96F2),
                Color(0xFF113A71)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<FetchUserByPhoneBloc, FetchUserByPhoneState>(
                  builder: (context, state) {
                if (state is UserLoading) {
                  return const CircularProgressIndicator();
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Nhập email hoặc memberID',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                hintText: 'Nhập thông tin tại đây',
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              final phone = phoneController.text;
                              if (phone.isNotEmpty) {
                                context
                                    .read<FetchUserByPhoneBloc>()
                                    .add(FetchUserByPhone(phone));
                                FocusScope.of(context)
                                    .unfocus(); // Hide the keyboard
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(12),
                              backgroundColor:
                                  Colors.white, // Nền trắng cho nút
                            ),
                            child: const Icon(
                              Icons.person_add,
                              color:
                                  Color(0xFF113A71), // Màu xanh đậm từ gradient
                            ),
                          ),
                        ],
                      ),
                      if (state is UserLoaded) ...{
                        const SizedBox(
                          height: 10,
                        ),
                        FriendCard(
                          id: idUser,
                          idOtherUser: state.phone,
                          name: state.name,
                          img: "${state.img}",
                          isRow: false,
                        ),
                      }
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      );
    },
  );
}

void showUnfollowDialog(
  BuildContext context,
  String userId,
  String friendId,
  String requestId,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text('Unfollow '),
        content: const Text(
          'Bạn sẽ không thể thấy trạng thái hoạt động và các bài viết của  nữa.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Hủy',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () {
              removeFriend(userId, friendId, requestId);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Unfollow',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> sendFriendRequest(
    String userId, String friendId, String name, String? imgUrl) async {
  try {
    await _firestore
        .collection('friendRequests')
        .doc('${userId}_$friendId')
        .set({
      'senderId': userId,
      'receiverId': friendId,
      'name': name,
      'image': imgUrl,
      'status': 'pending',
      'requestedAt': FieldValue.serverTimestamp(),
    });
    if (kDebugMode) {
      print("Friend request sent successfully");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Failed to send friend request: $e");
    }
  }
}

Future<void> acceptFriendRequest(String requestId, String userId,
    String friendId, String name, String? imgUrl) async {
  try {
    // Update the request status to accepted
    await _firestore
        .collection('friendRequests')
        .doc(requestId)
        .update({'status': 'accepted'});

    // Add to the 'friends' collection for both users
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('friends')
        .doc(friendId)
        .set({
      'id': friendId,
      'name': name,
      'image': imgUrl,
      'addedAt': FieldValue.serverTimestamp(),
    });

    await _firestore
        .collection('users')
        .doc(friendId)
        .collection('friends')
        .doc(userId)
        .set({
      'id': userId,
      'name': name,
      'image': imgUrl,
      'addedAt': FieldValue.serverTimestamp(),
    });

    if (kDebugMode) {
      print("Friend request accepted and friend added successfully");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Failed to accept friend request: $e");
    }
  }
}

Future<void> removeFriend(
    String userId, String friendId, String requestId) async {
  try {
    // Remove friend from the user's friend list
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('friends')
        .doc(friendId)
        .delete();

    // Remove the user from the friend's friend list
    await _firestore
        .collection('users')
        .doc(friendId)
        .collection('friends')
        .doc(userId)
        .delete();

    await _firestore.collection('friendRequests').doc(requestId).delete();

    if (kDebugMode) {
      print("Friend removed successfully");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Failed to remove friend: $e");
    }
  }
}
void createNewChat(BuildContext context,String currentUserId, String otherUserId,String name) async {
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
        name: name,
        chatId: chatDocRef.id,
        receiverId: otherUserId,
        receiverName: 'Tên của người nhận',
      ),
    ),
  );
}
