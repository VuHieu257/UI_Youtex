import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            // Handle back action
          },
        ),
        title: Text(
          'Thiết lập tài khoản',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Tài khoản
              Text(
                'Tài khoản',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildSettingItem('Tài khoản & bảo mật', Icons.security, () {}),
              _buildSettingItem('Địa chỉ', Icons.location_on, () {}),
              _buildSettingItem(
                  'Tài khoản/Thẻ ngân hàng', Icons.credit_card, () {}),
              _buildSettingItem('Quốc gia: 🇻🇳 Vietnam', Icons.flag, () {}),
              _buildSettingItem(
                  'Cài đặt thông báo', Icons.notifications, () {}),

              SizedBox(height: 20),

              // Section: Hỗ trợ
              Text(
                'Hỗ trợ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildSettingItem('Trung tâm hỗ trợ', Icons.headset_mic, () {}),
              _buildSettingItem('Tiêu chuẩn cộng đồng', Icons.group, () {}),
              _buildSettingItem(
                  'Điều khoản của ứng dụng', Icons.description, () {}),
              _buildSettingItem(
                  'Yêu cầu xóa tài khoản', Icons.delete_forever, () {}),

              SizedBox(height: 40),

              // Logout Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Handle log out
                  },
                  child: Text(
                    'Đăng xuất tài khoản',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for creating each setting item
  Widget _buildSettingItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
