import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/fanpage/avatar/Setting/Setting_edit.dart';

import '../../../../../core/colors/color.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Styles.light,)),

        title: Text(
          'Cài Đặt Trang', style: context.theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),          actions: [
        IconButton(
          icon: Icon(Icons.edit),
          color: Styles.light,

          onPressed: () {_showBottomSheet(context);},
        ),
        IconButton(
          icon: Icon(Icons.search),
          color: Styles.light,

          onPressed: () {},
        ),
      ],
      ),
      body: ListView(
        children: [
          _buildListItem(Icons.add, 'Tạo',(){},),
          _buildDivider(),
          _buildListItem(Icons.edit, 'Chỉnh sửa',(){Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPage()),);},),
          _buildDivider(),
          _buildListItem(Icons.admin_panel_settings, 'Quản trị viên',(){},),
          _buildDivider(),
          _buildListItem(Icons.settings, 'Cài đặt Trang',(){},),
          _buildDivider(),
          _buildListItem(Icons.lock, 'Trung tâm quyền riêng tư',(){},),
          _buildDivider(),
          _buildListItem(Icons.search, 'Tìm kiếm',(){},),
          _buildDivider(),
          _buildListItem(Icons.person_add, 'Mời bạn bè',(){},),
          _buildDivider(),
          _buildListItem(Icons.link, 'Liên kết đến Trang của bạn',(){},),
        ],
      ),
    );
  }

  Widget _buildListItem(IconData icon, String text, Function()? ontap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: ontap, // Gọi hàm ontap khi ListTile được bấm
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
    );
  }
}
void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20), // Bo góc ở phía trên của BottomSheet
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 16), // Khoảng cách giữa thanh kéo và các mục chọn
            ListTile(
              leading: Icon(Icons.note_alt_rounded, size: 28),
              title: Text('Bài Viết', style: TextStyle(fontSize: 16)),
              onTap: () {
                // Code xử lý khi chọn "Chụp ảnh mới"
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.video_call, size: 28),
              title: Text('Trực tiếp', style: TextStyle(fontSize: 16)),
              onTap: () {
                // Code xử lý khi chọn "Chọn ảnh trên máy"
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}