import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/colors/color.dart';

class CustomizationPage extends StatelessWidget {
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
                leading: Icon(Icons.camera_alt_outlined, size: 28),
                title: Text('Chụp ảnh mới', style: TextStyle(fontSize: 16)),
                onTap: () {
                  // Code xử lý khi chọn "Chụp ảnh mới"
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_outlined, size: 28),
                title: Text('Chọn ảnh trên máy', style: TextStyle(fontSize: 16)),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Styles.light,)),
        title: Text(
          'Trang', style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tùy chỉnh Trang',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 18),
            Text(
              'Ảnh đại diện của bạn là một trong những thứ đầu tiên mọi người nhìn thấy. Hãy thử dùng logo hoặc những hình ảnh đơn giản khiến họ dễ liên tưởng đến bạn.',
            ),
            SizedBox(height: 16),
            Stack(
        clipBehavior: Clip.none, // Cho phép phần tử con không bị cắt

        alignment: Alignment.center,
              children: [
                // Image cover
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(Asset.bg_ava), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Edit button on cover image
                Positioned(
                  bottom:-40,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(Asset.bg_ava_), // Replace with your image
                    child: Align(
                      alignment: Alignment.bottomRight*1.25,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.black),
                        onPressed: () {
                          _showBottomSheet(context);
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 8,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.grey),
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                  ),
                ),
                // Profile image

              ],

            ),
            SizedBox(height: 50),
            Center(
              child: Text(
                'You Textile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
