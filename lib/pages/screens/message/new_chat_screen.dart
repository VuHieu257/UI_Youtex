import 'package:flutter/material.dart';
import 'package:youtext_app/core/size/size.dart';
import 'package:youtext_app/core/themes/theme_extensions.dart';

import '../../../core/assets.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

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
            child: Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 30),
              // Add message list here
              alignment: Alignment.bottomCenter,
              child: _buildMessageCard(context),
            ),
          ),
          _buildBottomInputArea(context),
        ],
      ),
    );
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

  Widget _buildBottomInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration:  BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius:const BorderRadius.all(Radius.circular(20))),
      child: const Row(
        children: [
          Icon(Icons.add_reaction_outlined, color: Colors.black54),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tin nhắn',
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.more_horiz_outlined, color: Colors.black54),
          SizedBox(width: 8.0),
          Icon(Icons.mic_none, color: Colors.black54),
          SizedBox(width: 8.0),
          Icon(Icons.image_outlined, color: Colors.black54),
        ],
      ),
    );
  }
}
