import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtext_app/core/size/size.dart';
import 'package:youtext_app/core/themes/theme_extensions.dart';

import '../../../../core/assets.dart';
import '../../../../main.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool showEmojis=false;
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.arrow_back_ios,color: Colors.white,),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  // Chat bubbles with different alignment
                  _buildChatRow(
                    message: "Chào anh/chị, tôi đang tìm mua vài loại vải cotton...",
                    isMe: false,
                  ),
                  _buildChatRow(
                    message: "Chào anh/chị, chúng tôi có nhiều loại vải cotton...",
                    isMe: true,
                  ),
                  _buildChatRow(
                    message: "Tôi cần vải cotton mềm, thoáng khí...",
                    isMe: false,
                  ),
                  _buildChatRow(
                    message: "Chúng tôi có loại cotton 100%, mềm mịn...",
                    isMe: true,
                  ),
                  _buildChatRow(
                    message: "Tôi cần khoảng 50m",
                    isMe: false,
                  ),
                  _buildChatRow(
                    message: "Với số lượng này chúng tôi có thể giảm còn 180,000 đồng/mét.",
                    isMe: true,
                  ),
                ],
              ),
            ),
          ),
          _buildBottomInputArea(context),
        ],
      ),
    );
  }

  Widget _buildChatRow({required String message, required bool isMe}) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          CircleAvatar(
            backgroundImage: AssetImage(Asset.bgImageAvatar),
          ),
        ChatBubble(
          message: message,
          isMe: isMe,
        ),
      ],
    );
  }

  Widget _buildBottomInputArea(BuildContext context) {
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
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tin nhắn',
                    border: InputBorder.none,
                  ),
                ),
              ),
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
