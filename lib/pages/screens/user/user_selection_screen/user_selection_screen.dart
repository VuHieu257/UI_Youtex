import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/assets.dart';


class UserSelectionScreen extends StatefulWidget {
  const UserSelectionScreen({super.key});

  @override
  _UserSelectionScreenState createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen> {
  // Example data
  final List<Map<String, dynamic>> _users = [
    {"name": "Wade Warren", "avatar": Asset.bgImageAvatar},
    {"name": "Savannah Nguyen", "avatar": Asset.bgImageAvatar},
    {"name": "Esther Howard", "avatar": Asset.bgImageAvatar},
    {"name": "Ronald Richards", "avatar": Asset.bgImageAvatar},
    {"name": "Darrell Steward", "avatar": Asset.bgImageAvatar},
    {"name": "Jenny Wilson", "avatar": Asset.bgImageAvatar},
    {"name": "Brooklyn Simmons", "avatar": Asset.bgImageAvatar},
    {"name": "Bessie Cooper", "avatar": Asset.bgImageAvatar},
    {"name": "Jacob Jones", "avatar": Asset.bgImageAvatar},
  ];

  // Track selected users
  Map<String, bool> _selectedUsers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        title: Text('Thêm vào nhóm',style: context.theme.textTheme.headlineSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.w500),),
        actions: [
          TextButton(onPressed: () {

          }, child: Text("Thêm",style: context.theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),))
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(color: Colors.grey), // Color for the hint text
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                ),
                style: const TextStyle(color: Colors.black), // Color for the input text
                cursorColor: Colors.blue, // Color for the cursor
                onChanged: (value) {
                  setState(() {
                    // Handle search filtering here
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Gợi ý",style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold
              ),),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                String name = _users[index]["name"];
                String avatar = _users[index]["avatar"];
                bool isSelected = _selectedUsers[name] ?? false;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(avatar),
                  ),
                  title: Text(name),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        _selectedUsers[name] = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ]
      ),
    );
  }
}


