import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/home_mail.dart';
import 'package:ui_youtex/pages/screens/message/friend_list_scrren.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_profile_settings.dart';
import 'package:ui_youtex/pages/screens/voucher/voucher_view.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import '../../../oder_manager/oder_manager_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: context.height*0.22,
              decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [
                //     Color(0xFF040435),
                //     Color(0xFF040435),
                //     Color(0xFF113A71),
                //     Color(0xFF1E37C5),
                //     Color(0xff3EB0FF),
                //     Color(0xffDAF5FF),
                //   ],
                // ),
                // image: DecorationImage(
                //     image: AssetImage(Asset.bgImagePremium),fit: BoxFit.cover)
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Image.asset(Asset.bgImagePremium,fit: BoxFit.fitHeight,)),
                    ///Back ground no sign
                  // Positioned(
                  //     top: 0,
                  //       bottom:14,
                  //       right: 0,
                  //       left: 0,
                  //   child: Container(
                  //     decoration: const BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: [
                  //           Color(0xFF040435),
                  //           Color(0xFF040435),
                  //           Color(0xFF113A71),
                  //           Color(0xFF1E37C5),
                  //           Color(0xff3EB0FF),
                  //           Color(0xffDAF5FF),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 10,right: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:10.0,top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap:() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AccountSettingsScreen()),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Styles.greyLight.withOpacity(0.5),
                                  child: const Icon(Icons.settings_suggest_outlined, color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap:() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AccountSettingsScreen()),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Styles.greyLight.withOpacity(0.5),
                                  child:const Icon(Icons.notifications_none, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              padding: const EdgeInsets.all(3),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff3EB0FF),
                                    Color(0xFF113A71),
                                    Color(0xff3EB0FF),
                                    Color(0xff3EB0FF),
                                    Color(0xff3EB0FF),
                                    Color(0xFF113A71),
                                    Color(0xff3EB0FF),
                                    Color(0xffDAF5FF),
                                  ],
                                ),
                              ),
                              child: const CircleAvatar(
                                  radius: 50,
                              backgroundImage: AssetImage(Asset.bgImageAvatar,)
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top:12,left: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(8 ),
                                          gradient: const LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color(0xFF338BFF),
                                              Color(0xFF72CAEC),
                                              Color(0xFFA8E0F6),
                                            ],
                                          ),
                                      ),
                                      child: Text(
                                        'Premium',
                                        style: context.theme.textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.bold,color: Colors.white
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                        left: 0,
                                        child:Transform.rotate(
                                            angle: 320 * 3.141592653589793 / 180,
                                            child: Image.asset(Asset.iconPremium1,height: 20,width: 20,))),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Nguyễn Văn A',
                                  style:context.theme.textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  )
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '@cute',
                                  style: context.theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.white
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      'Member ID: 1234567890',
                                      style: context.theme.textTheme.titleMedium?.copyWith(
                                          color: Colors.white.withOpacity(0.71),
                                        fontWeight: FontWeight.w300
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff4A85D4).withOpacity(0.78),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Sửa chữa',
                                        style: context.theme.textTheme.titleMedium?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only( bottom:10,left: 8,right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Đơn hàng',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Xem thêm',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
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
                              Icons.local_shipping_outlined, 'Đã giao'),
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
           const Divider(),
            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMenuItem(
                    Icons.local_offer,
                    'Mã giảm giá',
                    context: context,
                    color:const Color(0xff113A71),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VoucherScreen())),
                  ),
                  _buildMenuItem(Icons.share, 'Chia sẻ App',
                      context: context,color:const Color(0xff113A71),
                  ),
                  _buildMenuItem(
                    Icons.shopping_bag,
                    'Mall của tôi',
                    context: context,
                    color:const Color(0xff113A71),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeMall())),
                  ),
                  _buildMenuItem(Icons.language, 'Ngôn ngữ/Language',
                      context: context,
                      subtitle: 'Tiếng Việt',
                    color:const Color(0xff113A71),
                  ),
                  _buildMenuItem(
                    Icons.people,
                    'Bạn bè',
                    context: context,
                    color:const Color(0xff113A71),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FriendListScreen())),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric( vertical:10,horizontal: 8),
              child: Text(
                'Hỗ trợ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildMenuItem(Icons.headset_mic, 'Trung tâm trợ giúp',
                  context: context,
            color:const Color(0xff113A71),),
            ),
          ],
        ),
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
              color: const Color(0xff113A71),
            ),
            if (hasNotification)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight:FontWeight.bold
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
    Function()? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8 ),
      decoration: BoxDecoration(
        color: const Color(0xffF3F3F3),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: color ?? const Color(0xff113A71), size: 24),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
              )
            : null,
        trailing: const Icon(Icons.chevron_right, color: Color(0xff113A71)),
        dense: true,
        onTap: onTap, // gọi hàm onTap
      ),
    );
  }
}
