import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import '../../../bloc/user_profile_bloc/user_profile_bloc.dart';
import '../../../core/assets.dart';
import '../../../core/colors/color.dart';
import '../../../model/user_profile.dart';
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
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Styles.blue,
                centerTitle: true,
                leading: null,
                automaticallyImplyLeading: false,
                title: Text(
                  'Message',
                  style: context.theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Styles.light,
                  ),
                ),
                actions: [
                  InkWell(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => FriendListScreen(currentUserId:currentUserId),));
                      },
                      child: const Icon(
                        Icons.edit_note_rounded,
                        color: Styles.light,
                      )),
                ],
              ),
              body: Column(
                children: [
                  Container(
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildOnlineFriend("Christopher", Asset.bgImageAvatar),
                        _buildOnlineFriend("Reese", Asset.bgImageAvatar),
                        _buildOnlineFriend("Jeffrey", Asset.bgImageAvatar),
                        _buildOnlineFriend("Laura", Asset.bgImageAvatar),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: firestore
                          .collection('chats')
                      .where('participants', arrayContains: currentUserId)
                          // .where('participants', arrayContains: "user1")
                          .orderBy('lastTimestamp', descending: true)
                          .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
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

                            String otherUserId = participants.firstWhere((id) => id != currentUserId);
                            // String otherUserId =
                            // participants.firstWhere((id) => id != "user1");
                            return FutureBuilder(
                              future: firestore.collection('users').doc(otherUserId).get(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                                if (!userSnapshot.hasData) {
                                  return const ListTile(title: Text("Loading..."));
                                }
                                if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                                  return const Center(child:Text(""));
                                }
                                var userData =
                                userSnapshot.data!.data() as Map<String, dynamic>;
                                String otherUserName = userData['name'];
                                return Slidable(
                                    key: const ValueKey(0),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dismissible: DismissiblePane(onDismissed: () {}),
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
                                      formatTimestamp(chat['lastTimestamp']),
                                          () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(
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

  Widget _buildOnlineFriend(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(imagePath),
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
                  Asset.bgImageAvatar), // Replace with your image assets
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
