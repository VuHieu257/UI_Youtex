import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';


import '../../../../core/assets.dart';
import '../../../../main.dart';
import '../../../widget_small/chat/chat_bubble.dart';


class ChatScreen extends StatefulWidget {
  final String chatId;
  final String receiverId;
  final String receiverName;

  const ChatScreen({super.key,
    required this.chatId,
    required this.receiverId,
    required this.receiverName,
  });


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool showEmojis=false;
  bool _isRecording = false;

  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _sendMessage() async {
    String message = _messageController.text.trim();
    _messageController.clear();
    if (message.isEmpty) return;

    // String currentUserId = _auth.currentUser!.uid;
    String currentUserId = "user1";

    var messageRef = _firestore
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .doc();

    await messageRef.set({
      'senderId': currentUserId,
      'receiverId': widget.receiverId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Cập nhật tin nhắn cuối cùng và thời gian trong collection chats
    await _firestore.collection('chats').doc(widget.chatId).update({
      'lastMessage': message,
      'lastTimestamp': FieldValue.serverTimestamp(),
    });

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyBoard(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: InkWell(onTap: () {
            Navigator.pop(context);
          },child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Martha Craig',style: context.theme.textTheme.headlineSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.w500),),
              Text('Đang hoạt động',style: context.theme.textTheme.titleSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.w500),),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call,color: Colors.white,),
              onPressed: () {
                // Handle call button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.video_call_rounded,color: Colors.white),
              onPressed: () {
                // Handle video call button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.list_outlined,color: Colors.white),
              onPressed: () {
                // Handle menu button press
              },
            ),
          ],
        ),
        // body: Stack(
        //   children: [
        //     SizedBox(
        //       height: context.height,
        //       child: SingleChildScrollView(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           crossAxisAlignment: CrossAxisAlignment.end,
        //           children: [
        //             Container(
        //               color: Colors.white,
        //               margin: const EdgeInsets.only(bottom: 30),
        //               // Add message list here
        //               alignment: Alignment.bottomCenter,
        //               child: _buildMessageCard(context),
        //             ),
        //             StreamBuilder(
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
        //                 return ListView.builder(
        //                   reverse: true,
        //                   shrinkWrap: true,
        //                   primary: true,
        //                   physics: const NeverScrollableScrollPhysics(),
        //                   itemCount: messages.length,
        //                   itemBuilder: (context, index) {
        //                     var messageData = messages[index];
        //                     // bool isMe = messageData['senderId'] == _auth.currentUser!.uid;
        //                     bool isMe = messageData['senderId'] == "user1";
        //                     return
        //                       _buildChatRow(
        //                         message: messageData['message'],
        //                         isMe: isMe,
        //                       );
        //                   },
        //                 );
        //               },
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //         bottom: 0,
        //         left: 10,
        //         right: 10,
        //         child: _buildBottomInputArea(context,_messageController)),
        //   ],
        // ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _firestore
                    .collection('chats')
                    .doc(widget.chatId)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var messageData = messages[index];
                      // bool isMe = messageData['senderId'] == _auth.currentUser!.uid;
                      bool isMe = messageData['senderId'] == "user1"; // Thay đổi ở đây
                      return _buildChatRow(
                        message: messageData['message'],
                        isMe: isMe,
                      );
                    },
                  );
                },
              ),
            ),
            _buildBottomInputArea(context, _messageController),
          ],
        )
      ),
    );
  }

  Widget _buildChatRow({required String message, required bool isMe}) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          const CircleAvatar(
            backgroundImage: AssetImage(Asset.bgImageAvatar),
          ),
        SizedBox(
          width: context.width*0.7,
          child: ChatBubble(
            message: message,
            isMe: isMe,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomInputArea(BuildContext context, TextEditingController controller) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          decoration:  BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius:const BorderRadius.all(Radius.circular(20))),
          child:  Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add_reaction_outlined, color: Colors.black54),
                onPressed: () {
                  setState(() {
                    showEmojis = !showEmojis;
                  });
                },
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Tin nhắn',
                    border: InputBorder.none,
                  ),
                  controller: controller,
                  onSubmitted: (value) {
                    _sendMessage();
                  },
                  onChanged: (value) {
                    setState(() {
                      controller.text=value;
                    });
                  },
                ),
              ),
              if(controller.text.isEmpty)...{
                const Icon(Icons.more_horiz_outlined, color: Colors.black54),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: _isRecording?const Icon(Icons.mic, color: Colors.blue):const Icon(Icons.mic_none, color: Colors.black54),
                  onPressed: () {
                    setState(() {
                      _isRecording = !_isRecording;
                    });
                  },
                ),
                const SizedBox(width: 8.0),
                const Icon(Icons.image_outlined, color: Colors.black54),
              }else if(controller.text.isNotEmpty)
                IconButton(
                icon: const Icon(Icons.send, color:Colors.blue),
                onPressed: _sendMessage,
                ),
            ],
          ),
        ),
        if (showEmojis)
          SizedBox(
            height: context.height*0.35,
            child: EmojiPicker(
              onEmojiSelected: (emoji, category) {
                // Handle the selected emoji
              },
            ),
          ),
        if (_isRecording)
          SizedBox(
            height: context.height*0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Turn on or hold to record",style: context.theme.textTheme.headlineSmall,),
                const SizedBox(height: 20,),
                const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.mic,color: Colors.white,)),
              ],
            ),
          ),
      ],
    );
  }
}
Widget _buildMessageCard(BuildContext context) {
  return Container(
    height: context.height*0.25,
    width: context.width*0.9,
    alignment: Alignment.bottomLeft,
    decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(Asset.bgCardMessage),fit: BoxFit.contain)
    ),
    child:  ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage(Asset.bgImageAvatar),
      ),
      title: Text('Martha Craig',style: context.theme.textTheme.titleMedium,),
      subtitle: Text("Let's start this conversation with great stories",style: context.theme.textTheme.titleSmall?.copyWith(fontSize: 10),),
    ),
  );
}
