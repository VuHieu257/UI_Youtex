import 'package:flutter/material.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_shop_analyst_view.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_shop_employee.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_shop_product.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_shop_view.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_view.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_profile_settings.dart';

class MaildetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50), // Tăng chiều cao AppBar
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E3799), Color(0xFF1E3799)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MallInfoScreen()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.person_outline, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserInfoHeader(),
            WalletCard(),
            SettingsList(), // Thêm phần danh sách cài đặt
          ],
        ),
      ),
    );
  }
}

class UserInfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Color(0xFF1E3799),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40, // Tăng kích thước ảnh đại diện
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/images_users.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16), // Tăng khoảng cách
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vải Hải Anh',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20, // Tăng font chữ
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Đơn hoàn tất 91.00%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 16, vertical: 12), // Tăng khoảng cách ngoài
      padding: EdgeInsets.symmetric(
          horizontal: 16, vertical: 20), // Tăng padding trong
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Tăng độ bo tròn
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8, // Tăng độ mờ của bóng
            offset: Offset(0, 4), // Điều chỉnh khoảng cách bóng
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              color: Colors.blue, size: 28), // Tăng kích thước icon
          SizedBox(width: 12),
          Text(
            'Ví người bán',
            style: TextStyle(
              fontSize: 16, // Tăng font chữ
              color: Colors.black87,
            ),
          ),
          Spacer(),
          Text(
            '160.100.111 đ',
            style: TextStyle(
              fontSize: 16, // Tăng font chữ
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget cho danh sách cài đặt
class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SettingsItem(
            icon: Icons.bar_chart,
            text: 'Bảng thống kê',
            onTap: () {},
          ),
          SettingsItem(
            icon: Icons.shopping_bag,
            text: 'Thông tin Shop',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShopOverviewScreen()));
            },
          ),
          SettingsItem(
            icon: Icons.notifications,
            text: 'Cài đặt thông báo',
            onTap: () {},
          ),
          SettingsItem(
            icon: Icons.people,
            text: 'Quản lý nhân viên',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmployeeListScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  SettingsItem({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16), // Tăng padding
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 28), // Tăng kích thước icon
            SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18, color: Colors.black87), // Tăng font chữ
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: Colors.grey, size: 18), // Tăng kích thước mũi tên
          ],
        ),
      ),
    );
  }
}
