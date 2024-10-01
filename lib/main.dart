import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:youtext_app/core/colors/color.dart';
import 'package:youtext_app/core/size/size.dart';
import 'package:youtext_app/core/themes/theme_extensions.dart';
import 'package:youtext_app/pages/screens/home/search_page/search_page.dart';
import 'package:youtext_app/pages/screens/message/group_chat_settings/group_chat_settings.dart';
import 'package:youtext_app/pages/screens/message/message.dart';
import 'package:youtext_app/pages/screens/message/new_chat_screen.dart';

import 'core/assets.dart';
import 'core/themes/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyAppThemes.lightTheme,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,
      home: const GroupChatSettings(),
      // home: const ManagerMemberScreen(),
      // home: const ChatScreen(),
      // home: const SearchPage(),
    );
  }
}

// class MessageListPage extends StatelessWidget {
//   final List<String> messages = ["Message 1", "Message 2", "Message 3"];
//
//   MessageListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Messages'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: ListView.builder(
//         itemCount: messages.length,
//         itemBuilder: (context, index) {
//           return Slidable(
//             actionPane: const SlidableDrawerActionPane(), // Old API version
//             actionExtentRatio: 0.25,
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: Colors.blueAccent,
//                 child: Text(messages[index][0]),
//               ),
//               title: Text(messages[index]),
//               subtitle: Text("Swipe left for actions"),
//             ),
//             secondaryActions: <Widget>[
//               IconSlideAction(
//                 caption: 'Notify',
//                 color: Colors.black,
//                 icon: Icons.notifications,
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Notification for ${messages[index]}')),
//                   );
//                 },
//               ),
//               IconSlideAction(
//                 caption: 'Delete',
//                 color: Colors.red,
//                 icon: Icons.delete,
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('${messages[index]} deleted')),
//                   );
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

//
// class MyApp extends StatefulWidget {
//   const MyApp({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
//   late final controller = SlidableController(this);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Slidable Example',
//       home: Scaffold(
//         body: ListView(
//           children: [
//             Slidable(
//               // Specify a key if the Slidable is dismissible.
//               key: const ValueKey(0),
//               // The start action pane is the one at the left or the top side.
//               startActionPane: ActionPane(
//                 // A motion is a widget used to control how the pane animates.
//                 motion: const ScrollMotion(),
//                 // A pane can dismiss the Slidable.
//                 dismissible: DismissiblePane(onDismissed: () {}),
//
//                 // All actions are defined in the children parameter.
//                 children: const [
//                   // A SlidableAction can have an icon and/or a label.
//                   SlidableAction(
//                     onPressed: doNothing,
//                     backgroundColor: Color(0xFFFE4A49),
//                     foregroundColor: Colors.white,
//                     icon: Icons.delete,
//                     label: 'Delete',
//                   ),
//                   SlidableAction(
//                     onPressed: doNothing,
//                     backgroundColor: Color(0xFF21B7CA),
//                     foregroundColor: Colors.white,
//                     icon: Icons.share,
//                     label: 'Share',
//                   ),
//                 ],
//               ),
//               // The end action pane is the one at the right or the bottom side.
//               endActionPane: ActionPane(
//                 motion: const ScrollMotion(),
//                 children: [
//                   SlidableAction(
//                     // An action can be bigger than the others.
//                     flex: 2,
//                     onPressed: (_) => controller.openEndActionPane(),
//                     backgroundColor: const Color(0xFF7BC043),
//                     foregroundColor: Colors.white,
//                     icon: Icons.archive,
//                     label: 'Archive',
//                   ),
//                   SlidableAction(
//                     onPressed: (_) => controller.close(),
//                     backgroundColor: const Color(0xFF0392CF),
//                     foregroundColor: Colors.white,
//                     icon: Icons.save,
//                     label: 'Save',
//                   ),
//                 ],
//               ),
//
//               // The child of the Slidable is what the user sees when the
//               // component is not dragged.
//               child: const ListTile(title: Text('Slide me')),
//             ),
//             Slidable(
//               controller: controller,
//               // Specify a key if the Slidable is dismissible.
//               key: const ValueKey(1),
//
//               // The start action pane is the one at the left or the top side.
//               startActionPane: const ActionPane(
//                 // A motion is a widget used to control how the pane animates.
//                 motion: ScrollMotion(),
//
//                 // All actions are defined in the children parameter.
//                 children: [
//                   // A SlidableAction can have an icon and/or a label.
//                   SlidableAction(
//                     onPressed: doNothing,
//                     backgroundColor: Color(0xFFFE4A49),
//                     foregroundColor: Colors.white,
//                     icon: Icons.delete,
//                     label: 'Delete',
//                   ),
//                   SlidableAction(
//                     onPressed: doNothing,
//                     backgroundColor: Color(0xFF21B7CA),
//                     foregroundColor: Colors.white,
//                     icon: Icons.share,
//                     label: 'Share',
//                   ),
//                 ],
//               ),
//
//               // The end action pane is the one at the right or the bottom side.
//               endActionPane: ActionPane(
//                 motion: const ScrollMotion(),
//                 dismissible: DismissiblePane(onDismissed: () {}),
//                 children: const [
//                   SlidableAction(
//                     // An action can be bigger than the others.
//                     flex: 2,
//                     onPressed: doNothing,
//                     backgroundColor: Color(0xFF7BC043),
//                     foregroundColor: Colors.white,
//                     icon: Icons.archive,
//                     label: 'Archive',
//                   ),
//                   SlidableAction(
//                     onPressed: doNothing,
//                     backgroundColor: Color(0xFF0392CF),
//                     foregroundColor: Colors.white,
//                     icon: Icons.save,
//                     label: 'Save',
//                   ),
//                 ],
//               ),
//
//               // The child of the Slidable is what the user sees when the
//               // component is not dragged.
//               child: const ListTile(title: Text('Slide me')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.lightBlueAccent.shade100.withOpacity(0.5) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: context.width*0.65,
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

