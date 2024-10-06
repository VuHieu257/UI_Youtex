import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/colors/color.dart';

class UserOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Styles.blue,
         leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back_ios,color: Styles.light,)),
        title: Text('Tùy Chọn',style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bọc ảnh đại diện và các nút tùy chọn trong một widget hình tròn
            Column(
              children: [
                ClipOval(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(Asset.bgImageAvatar), // Thay thế bằng ảnh thực tế
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Martha Craig',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                // Bọc các nút tùy chọn trong hình tròn và thêm hiệu ứng nhấn
                Container(
                  padding: EdgeInsets.all(10.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          // Xử lý khi nhấn nút "Tìm tin nhắn"
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,),
                            child: Column(
                            children: [
                              Icon(Icons.search, size: 30),
                              Text('Tìm tin nhắn', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Xử lý khi nhấn nút "Trang cá nhân"
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,),
                          child: Column(
                            children: [
                              Icon(Icons.person, size: 30),
                              Text('Trang cá nhân', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Xử lý khi nhấn nút "Tắt thông báo"
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,),
                          child: Column(
                            children: [
                              Icon(Icons.notifications_on_outlined, size: 30),
                              Text('Tắt Thông báo', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            // Các tùy chọn hành động
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.photo, color: Colors.black),
                    title: Text('Xem hình ảnh, file và liên kết'),
                    onTap: () {
                      // Xử lý khi nhấn
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.report, color: Colors.black),
                    title: Text('Báo cáo tin nhắn'),
                    onTap: () {
                      // Xử lý khi nhấn
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.block, color: Colors.black),
                    title: Text('Chặn'),
                    onTap: () {
                      // Xử lý khi nhấn
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete, color: Colors.black),
                    title: Text('Xóa lịch sử trò chuyện'),
                    onTap: () {
                      // Xử lý khi nhấn
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
