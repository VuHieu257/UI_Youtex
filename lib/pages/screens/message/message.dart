import 'package:flutter/material.dart';
import '../../../core/assets.dart';
import '../../../core/colors/color.dart';
class MessagesScreen extends StatefulWidget {

  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<Map<String, String>> friends = [
    {'name': 'Christopher', 'image': 'https://via.placeholder.com/50'},
    {'name': 'Reese', 'image': 'https://via.placeholder.com/50'},
    {'name': 'Jeffrey', 'image': 'https://via.placeholder.com/50'},
    {'name': 'Laura', 'image': 'https://via.placeholder.com/50'},
  ];

  final List<Map<String, String>> messages = [
    {'name': 'Martin Randolph', 'message': 'What\'s man!', 'time': '9:40 AM', 'image': 'https://via.placeholder.com/50'},
    {'name': 'Andrew Parker', 'message': 'Ok, thanks!', 'time': '9:25 AM', 'image': 'https://via.placeholder.com/50'},
    {'name': 'Karen Castillo', 'message': 'See you in Town', 'time': 'Fri', 'image': 'https://via.placeholder.com/50'},
    {'name': 'Maisy Humphrey', 'message': 'Have a good day!', 'time': 'Fri', 'image': 'https://via.placeholder.com/50'},
    {'name': 'Joshua Lawrence', 'message': 'The business plan...', 'time': 'Thu', 'image': 'https://via.placeholder.com/50'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Settings button action
          },
        ),
        title: Text('Messages'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Edit button action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Online Friends Horizontal List
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(friends[index]['image']!),
                      ),
                      SizedBox(height: 5),
                      Text(friends[index]['name']!),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          // Messages Vertical List
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(messages[index]['image']!),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  title: Text(messages[index]['name']!),
                  subtitle: Text(messages[index]['message']!),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(messages[index]['time']!),
                      Icon(Icons.check_circle, color: Colors.blue, size: 18),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
