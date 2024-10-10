import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/fanpage/avatar/Setting/Setting_edit_bio.dart';
import 'package:ui_youtex/pages/screens/fanpage/avatar/Setting/Setting_edit_details.dart';

import '../../../../../core/colors/color.dart';

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Styles.light,)),
        title: Text(
          'Chỉnh Sửa Trang', style: context.theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildProfileSection(context),
          SizedBox(height: 20),
          _buildCoverPhotoSection(),
          SizedBox(height: 20),
          _buildBiographySection(context),
          SizedBox(height: 20),
          _buildDetailsSection(),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ảnh đại diện',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDetailPage(), // Thay bằng trang chỉnh sửa
                  ),
                );
              },
              child: Text('Chỉnh sửa'),
            ),
          ],
        ),
             Center(
          child: ClipOval(
            child: Image.asset(
              Asset.bg_ava_,
              width: 200,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],

    );
  }

  Widget _buildCoverPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ảnh bìa',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                // Edit action
              },
              child: Text('Chỉnh sửa'),
            ),
          ],
        ),
        Center(
          child: Image.asset(
            Asset.bg_ava,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildBiographySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tiểu sử',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {_showBottomSheet(context);

                // Edit action
              },
              child: Text('Chỉnh sửa'),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Cung cấp đa dạng các loại vải trên thị trường.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chi tiết',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                // Edit action
              },
              child: Text('Chỉnh sửa'),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, size: 20),
            SizedBox(width: 10),
            Text('Gia Lâm, Hà Nội',style: TextStyle(fontSize: 18),),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.phone, size: 20),
            SizedBox(width: 8),
            Text('+84 123456789',style: TextStyle(fontSize: 18),),
          ],
        ),
      ],
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
              leading: Icon(Icons.edit, size: 28),
              title: Text('Chỉnh Sửa Tiểu Sử', style: TextStyle(fontSize: 16)),
              onTap: () {
                // Code xử lý khi chọn "Chụp ảnh mới"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BioEditPage(), // Thay bằng trang chỉnh sửa
                  ),
                );              },
            ),
            ListTile(
              leading: Icon(Icons.restore_from_trash, size: 28),
              title: Text('Gỡ', style: TextStyle(fontSize: 16)),
              onTap: () {
                // Code xử lý khi chọn "Chọn ảnh trên máy"

              },
            ),
          ],
        ),
      );
    },
  );
}