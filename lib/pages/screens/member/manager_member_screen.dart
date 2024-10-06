import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/assets.dart';

class ManagerMemberScreen extends StatefulWidget {
  const ManagerMemberScreen({super.key});

  @override
  _ManagerMemberScreenState createState() => _ManagerMemberScreenState();
}

class _ManagerMemberScreenState extends State<ManagerMemberScreen> {
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
  void _showUserInfoModal(BuildContext context, String name, String avatar) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar at the top of the modal
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              Text("Thông tin thành viên",style: context.theme.textTheme.headlineMedium,),
              Divider(),
              const SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(avatar),
                  radius: 30,
                ),
                title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              // Options
              ListTile(
                title: const Text('Xem trang cá nhân', style: TextStyle(color: Colors.black)),
                onTap: () {
                  // Handle navigation to user profile
                },
              ),
              ListTile(
                title: const Text('Bổ nhiệm làm quản trị viên', style: TextStyle(color: Colors.black)),
                onTap: () {
                  _showAdminConfirmationDialog(context,title:"Bổ nhiệm $name làm quản trị viên?" ,content: "$name có thể duyệt thành viên và thay đổi các cài đặt của nhóm",textLeft: "Hủy",textRight: "Bổ nhiệm");
                },
              ),
              ListTile(
                title: const Text('Xóa khỏi nhóm', style: TextStyle(color: Colors.red)),
                onTap: () {
                  _showAdminConfirmationDialog(context,title:"Xóa $name khỏi nhóm" ,content: "Xóa và chặn $name khỏi nhóm",textLeft: "Hủy",textRight: "Xóa");

                },
              ),
            ],
          ),
        );
      },
    );
  }
  void _showAdminConfirmationDialog(BuildContext context,{required String title,required String content,required String textLeft,required String textRight}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title,style: context.theme.textTheme.headlineSmall,),
          content: Text(content,style: context.theme.textTheme.titleMedium,),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(textLeft,style: context.theme.textTheme.titleMedium?.copyWith(color: Colors.blue),),
            ),
            const SizedBox(width: 100,),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Success",style: context.theme.textTheme.titleMedium,),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text(textRight,style: context.theme.textTheme.titleMedium?.copyWith(
                  color:textRight=="Xóa"? Colors.red : Colors.blue
              ),),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        title: Text('Quản lý thành viên',style: context.theme.textTheme.headlineSmall?.copyWith(color: Colors.white,fontWeight: FontWeight.w500),),
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
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(avatar),
                  ),
                  title: Text(name),
                  onTap: () {
                    _showUserInfoModal(context,name,avatar);
                  },
                );
              },
            ),
          ]
      ),
    );
  }
}