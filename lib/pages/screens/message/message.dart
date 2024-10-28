import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
 import '../../../core/assets.dart';
import '../../../core/colors/color.dart';
import '../../widget_small/widget.dart';
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(
            // onTap: () => Navigator.pop(context),
            onTap: () {

            },
            child: const Icon(Icons.settings_suggest_outlined,color: Styles.light,)),
        title: Text('Message',style: context.theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
        actions: [
          InkWell(
              // onTap: () => Navigator.pop(context),
              onTap: () {

              },
              child: const Icon(Icons.edit_note_rounded,color: Styles.light,)),
        ],
      ),
      body: Column(
        children: [
          // Online Friends Section
          Container(
            height: 100,
            padding: const EdgeInsets.all(8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildOnlineFriend("Christopher",Asset.bgImageAvatar),
                _buildOnlineFriend("Reese", Asset.bgImageAvatar),
                _buildOnlineFriend("Jeffrey", Asset.bgImageAvatar),
                _buildOnlineFriend("Laura", Asset.bgImageAvatar),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Slidable(
                  key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    children:   [
                       SlidableAction(
                        flex: 1,
                        // onPressed: (context) => customShowReportSheet(context),
                        onPressed: (context) => customShowBlockSheet(context),
                        foregroundColor: Colors.black,
                        icon: Icons.clear_all_sharp,
                        // borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      SlidableAction(
                        onPressed: (context) => customShowBottomSheet(context),
                        // backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.black,
                        icon: Icons.notifications,
                      ),
                      const SlidableAction(
                        onPressed: doNothing,
                        // backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.black,
                        icon: Icons.delete,
                      ),
                    ],
                  ),
                  child:  _buildMessageTile("Martin Randolph", "You: What's man!", "9:40 AM", "3"),
                ),
                _buildMessageTile("Andrew Parker", "You: Ok, thanks!", "9:25 AM"),
                _buildMessageTile("Karen Castillo", "You: Ok, See you in To...", "Fri"),
                _buildMessageTile("Maisy Humphrey", "Have a good day, Maisy!", "Fri"),
                _buildMessageTile("Joshua Lawrence", "The business plan loo...", "Thu"),
              ],
            ),
          ),
        ],
      ),
    );
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

  Widget _buildMessageTile(String name, String message, String time, [String? unreadCount]) {
    return ListTile(
      leading: Stack(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(Asset.bgImageAvatar), // Replace with your image assets
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
                child: Text(unreadCount, style: const TextStyle(fontSize: 12, color: Colors.white)),
              ),
            )
        ],
      ),
      title: Text(name),
      subtitle: Row(children: [
        Text(message),
        const SizedBox(width:10,),
        Text(time, style: const TextStyle(fontSize: 12)),
      ],),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          unreadCount == null? const Icon(Icons.check_circle, color: Colors.grey, size: 16):const Icon(Icons.circle_outlined, color: Colors.grey, size: 16),
        ],
      ),
    );
  }
}

void doNothing(BuildContext context) {}