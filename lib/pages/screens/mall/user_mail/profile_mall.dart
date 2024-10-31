import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_employee.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_view.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import '../../../widget_small/appbar/cus_appbar_background.dart';
import '../../user/user_profile/user_profile_settings.dart';
import '../user_mail_settings/mail_infor_view.dart';

class UserMailDetailsShop extends StatelessWidget {
  const UserMailDetailsShop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            UserInfoHeader(),
            WalletCard(),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:8.0),
              child: Text("Cài đặt",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            SettingsList(),
          ],
        ),
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Styles.colorF3F3F3,
        borderRadius: BorderRadius.circular(12), // Tăng độ bo tròn
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 2, // Tăng độ mờ của bóng
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              color: Styles.nearPrimary, size: 28), // Tăng kích thước icon
          SizedBox(width: 12),
          Text(
            'Ví người bán',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.bold
            ),
          ),
          Spacer(),
          Text(
            '160.100.111 đ',
            style: TextStyle(
              fontSize: 16, // Tăng font chữ
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget cho danh sách cài đặt
class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SettingsItem(
            icon: Icons.bar_chart,
            text: 'Bảng thống kê',
            onTap: () {},
          ),
          SettingsItem(
            icon: Icons.shopping_bag_outlined,
            text: 'Thông tin Shop',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShopOverviewScreen()));
            },
          ),
          SettingsItem(
            icon: Icons.notifications_none,
            text: 'Cài đặt thông báo',
            onTap: () {},
          ),
          SettingsItem(
            icon: Icons.people_outline,
            text: 'Quản lý nhân viên',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EmployeeListScreen()));
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

  const SettingsItem({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
        color: Styles.colorF3F3F3,
        borderRadius: BorderRadius.circular(12), // Tăng độ bo tròn
        boxShadow: [
          BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 3,
          offset: const Offset(0, 4),
          ),
        ],),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12), // Tăng padding
        child: Row(
          children: [
            Icon(icon, color: Styles.nearPrimary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 18, color: Colors.black87,fontWeight: FontWeight.bold), // Tăng font chữ
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.grey, size: 18), // Tăng kích thước mũi tên
          ],
        ),
      ),
    );
  }
}
