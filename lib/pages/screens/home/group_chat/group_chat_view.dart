import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/group_chat/profile-boxchat.dart';

import '../../../../core/colors/color.dart';

class GroupCreationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Styles.blue,
        leading: IconButton(
          icon: Text('Hủy',style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Styles.light,
          ),),
          onPressed: () {
            // Xử lý khi nhấn nút "Hủy"
          },
        ),
        title:Text('Tạo nhóm mới',style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
        actions: [
          TextButton(
            onPressed: () {
              // Xử lý khi nhấn nút "Tạo"
            },
            child:Text('Tạo',style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Styles.light,
            ),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Tên nhóm (không bắt buộc)',
               ),
            ),
            SizedBox(height: 10),
            Container(
              width: 450,
               height: 40,
               child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Tìm kiếm',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Số lượng thành viên trong danh sách
                itemBuilder: (context, index) {
                  return CheckboxListTile(

                    value: true,
                    onChanged: (bool? value) {

                    },
                    activeColor: Styles.blue,
                     title: Row(
                      children: [
                        GestureDetector(
                          onTap:(){Navigator.push(context,MaterialPageRoute(builder: (context) =>   UserOptionsPage()));},

                          child: CircleAvatar(
                            backgroundImage: AssetImage(Asset.bgImageAvatar) // Thay thế bằng ảnh thực tế
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Tên thành viên $index'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
