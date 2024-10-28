import 'package:flutter/material.dart';

class MallInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin Mall', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.white,
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MallInfoButton(
              title: 'Thông tin doanh nghiệp',
              onTap: () {
                // Điều hướng đến trang chi tiết Thông tin doanh nghiệp
              },
            ),
            SizedBox(height: 8),
            MallInfoButton(
              title: 'Giấy tờ',
              onTap: () {
                // Điều hướng đến trang chi tiết Giấy tờ
              },
            ),
            SizedBox(height: 8),
            MallInfoButton(
              title: 'Ngân hàng',
              onTap: () {
                // Điều hướng đến trang chi tiết Ngân hàng
              },
            ),
            SizedBox(height: 8),
            MallInfoButton(
              title: 'Mô tả shop',
              onTap: () {
                // Điều hướng đến trang chi tiết Mô tả shop
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MallInfoButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  MallInfoButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.blue, width: 1), // Khung màu xanh
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
