import 'package:flutter/material.dart';
import 'package:ui_youtex/pages/screens/mall/register_mall/register_maiil_identification_shop.dart';
import 'package:ui_youtex/pages/screens/mall/register_mall/register_maiil_infor_exhibit.dart';
import 'package:ui_youtex/pages/screens/mall/register_mall/register_maiil_infor_shop.dart';
import 'package:ui_youtex/pages/screens/mall/register_mall/register_mail_infor_banking.dart';
import 'package:ui_youtex/pages/screens/mall/register_mall/register_mall_infor.dart';

import '../../../../core/colors/color.dart';
import '../../../widget_small/appbar/custome_appbar_circle.dart';

class MallInfoScreen extends StatelessWidget {
  const MallInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: cusAppBarCircle(context, title: "Thông tin Mall"),
            ),
            const Divider(),
            const SettingsList(),
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Styles.colorF3F3F3,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              color: Styles.nearPrimary, size: 28),
          SizedBox(width: 12),
          Text(
            'Ví người bán',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            '01 đ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

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
            text: 'Thông tin doanh nghiệp',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterMallinforScreen()));
            },
          ),
          SettingsItem(
            icon: Icons.shopping_bag_outlined,
            text: 'Giấy tờ',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const RegisterMallinforExhibitiScreen()));
            },
          ),
          // SettingsItem(
          //   icon: Icons.notifications_none,
          //   text: 'Ngân hàng',
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) =>
          //                 const RegisterMallinforbankingScreen()));
          //   },
          // ),
          SettingsItem(
            icon: Icons.people_outline,
            text: 'Thông tin vận chuyển',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const RegisterMallinforShopScreen()));
            },
          ),
          SettingsItem(
            icon: Icons.people_outline,
            text: 'Thông tin xác thực',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const RegisterMallIdentificationScreen()));
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

  const SettingsItem(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Styles.colorF3F3F3,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            // Icon(icon, color: Styles.nearPrimary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}
