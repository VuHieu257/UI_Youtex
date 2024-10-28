import 'package:flutter/material.dart';
import 'package:ui_youtex/pages/screens/message/friend_list_scrren.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_details_shop.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_view.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_profile_settings.dart';
import 'package:ui_youtex/pages/screens/voucher/voucher_view.dart';

import '../../../oder_manager/oder_manager_view.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header với ảnh và thông tin người dùng
                Container(
                  padding:
                      EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E3799), Color(0xFF4A69BD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Image.asset(
                            'assets/images/images_users.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Premium',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Nguyễn Văn A',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '@cute',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[700],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Sửa chữa',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Member ID: 1234567890',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.settings, color: Colors.white),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AccountSettingsScreen()),
                                );
                              }),
                          IconButton(
                            icon:
                                Icon(Icons.notifications, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Nội dung khác

                // Đơn hàng Section
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Đơn hàng',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Xem thêm',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderManagementScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: _buildOrderStatusItem(
                                  Icons.access_time, 'Chờ xác nhận', true),
                            ),
                            Expanded(
                              child: _buildOrderStatusItem(
                                  Icons.inventory_2, 'Chờ giao hàng'),
                            ),
                            Expanded(
                              child: _buildOrderStatusItem(
                                  Icons.local_shipping, 'Đã giao'),
                            ),
                            Expanded(
                              child: _buildOrderStatusItem(
                                  Icons.cancel_outlined, 'Đã hủy'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Menu Items
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuItem(
                        Icons.local_offer,
                        'Mã giảm giá',
                        context: context,
                        color: Colors.blue[700],
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VoucherScreen())),
                      ),
                      _buildMenuItem(Icons.share, 'Chia sẻ App',
                          context: context, color: Colors.blue[700]),
                      _buildMenuItem(
                        Icons.shopping_bag,
                        'Mall của tôi',
                        context: context,
                        color: Colors.blue[700],
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MaildetailsScreen())),
                      ),
                      _buildMenuItem(Icons.language, 'Ngôn ngữ/Language',
                          context: context,
                          subtitle: 'Tiếng Việt',
                          color: Colors.blue[700]),
                      _buildMenuItem(
                        Icons.people,
                        'Bạn bè',
                        context: context,
                        color: Colors.blue[700],
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FriendListScreen())),
                      ),
                    ],
                  ),
                ),

                // Hỗ trợ
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Hỗ trợ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _buildMenuItem(Icons.headset_mic, 'Trung tâm trợ giúp',
                      context: context, color: Colors.blue[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusItem(IconData icon, String label,
      [bool hasNotification = false]) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Icon(
              icon,
              size: 28,
              color: Colors.blue[700],
            ),
            if (hasNotification)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    String? subtitle,
    Color? color,
    required BuildContext context,
    Function()? onTap, // thêm tham số onTap
  }) {
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
        leading: Icon(icon, color: color ?? Colors.grey[600], size: 24),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              )
            : null,
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
        dense: true,
        onTap: onTap, // gọi hàm onTap
      ),
    );
  }
}
