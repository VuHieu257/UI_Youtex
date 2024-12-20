import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/util/constants.dart';
import '../../../bloc/user_profile_bloc/user_profile_bloc.dart';
import '../../../core/assets.dart';
import '../../../core/colors/color.dart';
import '../../widget_small/widget.dart';
import 'chat/chat_screen.dart';
import 'friend_list_scrren.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(FetchProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
      if (state is UserProfileLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserProfileError) {
        return Text(state.message);
      } else if (state is UserProfileLoaded) {
        final user = state.user;
        final currentUserId = user.phone;
        final nameCurrentUser = user.name;
        final imgCurrentUser = user.image;
        return GestureDetector(
          onTap: () => NetworkConstants.hideKeyBoard(),
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10, bottom: 10),
                  decoration: const BoxDecoration(
                    color: Styles.blue,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          // controller: searchController,
                          onSubmitted: (query) {
                            // if (query.isNotEmpty) {
                            //   performSearch(query);
                            // }
                          },
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FriendListScreen(
                                      currentUserId: currentUserId,
                                      nameCurrent: nameCurrentUser,
                                      imgCurrentUser: "$imgCurrentUser"),
                                ));
                          },
                          child: const Icon(
                            Icons.edit_note_rounded,
                            color: Styles.light,
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUserId)
                          .collection('friends')
                          .snapshots()
                          .map((snapshot) =>
                              snapshot.docs.map((doc) => doc.data()).toList()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Có lỗi xảy ra"),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("bạn chưa có bạn bè"),
                          );
                        }
                        final friendsList = snapshot.data!;
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                          scrollDirection: Axis.horizontal,
                          itemCount: friendsList.length,
                          itemBuilder: (context, index) {
                            final friend = friendsList[index];
                            return _buildOnlineFriend(friend['name'],
                                Asset.bgImageUser, friend['image']);
                          },
                        );
                      }),
                ),
                Expanded(
                  flex: 5,
                  child: StreamBuilder(
                    stream: firestore
                        .collection('chats')
                        .where('participants', arrayContains: currentUserId)
                        // .where('participants', arrayContains: "user1")
                        .orderBy('lastTimestamp', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text("Không có cuộc trò chuyện nào"));
                      }
                      var chatDocs = snapshot.data!.docs;

                      if (chatDocs.isEmpty) {
                        return const Center(
                            child: Text("Không có cuộc trò chuyện nào"));
                      }
                      return ListView.builder(
                        itemCount: chatDocs.length,
                        itemBuilder: (context, index) {
                          var chat = chatDocs[index];
                          var participants = chat['participants'] as List;
                          String otherUserId = participants
                              .firstWhere((id) => id != currentUserId);
                          // String otherUserId =
                          // participants.firstWhere((id) => id != "user1");
                          return FutureBuilder(
                            future: firestore
                                .collection('users')
                                .doc(otherUserId)
                                .get(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                              if (!userSnapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (!userSnapshot.hasData ||
                                  !userSnapshot.data!.exists) {
                                return const Center(child: Text(""));
                              }
                              var userData = userSnapshot.data!.data()
                                  as Map<String, dynamic>;
                              String otherUserName = userData['name'];
                              String formattedTimestamp = chat['lastTimestamp'] != null
                                  ? formatTimestamp(chat['lastTimestamp'])
                                  : "No timestamp";
                              return Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    dismissible:
                                        DismissiblePane(onDismissed: () {}),
                                    children: [
                                      SlidableAction(
                                        flex: 1,
                                        // onPressed: (context) => customShowReportSheet(context),
                                        onPressed: (context) =>
                                            customShowBlockSheet(context),
                                        foregroundColor: Colors.black,
                                        icon: Icons.clear_all_sharp,
                                        // borderRadius: BorderRadius.all(Radius.circular(50)),
                                      ),
                                      SlidableAction(
                                        onPressed: (context) =>
                                            customShowBottomSheet(context),
                                        // backgroundColor: Color(0xFF0392CF),
                                        foregroundColor: Colors.black,
                                        icon: Icons.notifications,
                                      ),
                                      SlidableAction(
                                        onPressed: (context) =>
                                            doNothing(context, chat.id),
                                        // backgroundColor: Color(0xFF0392CF),
                                        foregroundColor: Colors.black,
                                        icon: Icons.delete,
                                      ),
                                    ],
                                  ),
                                  child: _buildMessageTile(
                                    otherUserName,
                                    chat['lastMessage'],
                                    formattedTimestamp,
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                            currentUserId: currentUserId,
                                            name: otherUserName,
                                            chatId: chat.id,
                                            receiverId: otherUserId,
                                            receiverName: otherUserName,
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return const Center(
        child: Text("Có lỗi xảy ra"),
      );
    });
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime); // dd/MM/yyyy hh:mm AM/PM
  }

  Widget _buildOnlineFriend(String name, String imagePath, String img) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: img.isNotEmpty
                    ? NetworkImage(img) as ImageProvider
                    : AssetImage(imagePath),
              ),
              const Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.green,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMessageTile(
      String name, String message, String time, void Function()? onTap,
      [String? unreadCount]) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Stack(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                  Asset.bgImageUser), // Replace with your image assets
            ),
            const Positioned(
              top: 0,
              left: 0,
              child: CircleAvatar(
                radius: 7,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
            if (unreadCount != null)
              Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(unreadCount,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white)),
                ),
              )
          ],
        ),
        title: Text(name),
        subtitle: Row(
          children: [
            Text(message),
            const SizedBox(
              width: 10,
            ),
            Text(time, style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            unreadCount == null
                ? const Icon(Icons.check_circle, color: Colors.grey, size: 16)
                : const Icon(Icons.circle_outlined,
                    color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}

Future<void> doNothing(BuildContext context, String messageId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var messages = await firestore
      .collection('chats')
      .doc(messageId)
      .collection('messages')
      .get();

  for (var doc in messages.docs) {
    await firestore
        .collection('chats')
        .doc(messageId)
        .collection('messages')
        .doc(doc.id)
        .delete();
  }

  await firestore.collection('chats').doc(messageId).delete();

  Navigator.pop(context);
}
