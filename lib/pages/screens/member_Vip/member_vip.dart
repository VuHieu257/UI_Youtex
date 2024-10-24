import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/home/home_mall.dart';
import 'package:ui_youtex/pages/screens/member_Vip/free_trail.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_plan_vip.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_plan_prenium.dart';

import '../../../core/assets.dart';

class MembershipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  alignment: Alignment.bottomLeft,
                ),
                Column(
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Membership',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        _buildPlanCard(
                          title: 'User Bình Thường',
                          price: 'Miễn phí',
                          features: [
                            _buildFeature(
                              icon: Icons.check_circle_outline,
                              text: 'Sử dụng các tính năng cơ bản của app',
                            ),
                            _buildFeature(
                              icon: Icons.people_outline,
                              text: 'Tạo nhóm (tối đa 5 người/nhóm)',
                            ),
                          ],
                          onTap: null, // Không điều hướng cho gói miễn phí
                          showInterest: false,
                        ),
                        const SizedBox(height: 16),
                        _buildPlanCard(
                          title: 'VIP',
                          features: [
                            _buildFeature(
                              icon: Icons.block_outlined,
                              text: 'Không có quảng cáo',
                            ),
                            _buildFeature(
                              icon: Icons.file_download_outlined,
                              text: 'Tải xuống nhật ký (10 bộ/tháng)',
                            ),
                            _buildFeature(
                              icon: Icons.edit_outlined,
                              text:
                                  'Tuỳ chỉnh giao diện cơ bản (thay đổi thông tin người dùng)',
                            ),
                            _buildFeature(
                              icon: Icons.security,
                              text: 'Bảo hiểm đơn hàng - Buff Youtex',
                            ),
                            _buildFeature(
                              icon: Icons.people_outline,
                              text: 'Quản lý nhân viên (tối đa 10 tài khoản)',
                            ),
                          ],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VipPlanScreen(), // Link to VIP page
                              ),
                            );
                          },
                          showInterest: true,
                          context: context, // Pass context here
                        ),
                        const SizedBox(height: 16),
                        _buildPlanCard(
                          title: 'Premium',
                          features: [
                            _buildFeature(
                              icon: Icons.block_outlined,
                              text: 'Không có quảng cáo',
                            ),
                            _buildFeature(
                              icon: Icons.star_border,
                              text: 'Biểu tượng Premium',
                            ),
                            _buildFeature(
                              icon: Icons.emoji_events_outlined,
                              text: 'Truy cập nội dung độc quyền',
                            ),
                            _buildFeature(
                              icon: Icons.file_download_outlined,
                              text: 'Tải xuống nhật ký không giới hạn',
                            ),
                            _buildFeature(
                              icon: Icons.people_outline,
                              text:
                                  'Quản lý nhân viên không giới hạn tài khoản',
                            ),
                            _buildFeature(
                              icon: Icons.security,
                              text: 'Bảo hiểm đơn hàng - Buff Youtex',
                            ),
                            _buildFeature(
                              icon: Icons.post_add,
                              text: 'Hỗ trợ đăng bài quảng cáo (10 bài/tháng)',
                            ),
                            _buildFeature(
                              icon: Icons.campaign,
                              text: 'Hỗ trợ marketing cao cấp',
                            ),
                          ],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PremiumPlanScreen(), // Link to Premium page
                              ),
                            );
                          },
                          showInterest: true,
                          context: context, // Pass context here
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height / 14,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF218FF2), // Light blue
                            Color(0xFF13538C), // Dark blue
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return HomeMall();
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Start 7-Day Free Trial',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    String? price,
    required List<Widget> features,
    bool showInterest = false,
    BuildContext? context, // Add context here to use in the showDialog
    VoidCallback? onTap, // Add onTap function to handle card click
  }) {
    return GestureDetector(
      onTap: onTap, // Detect taps and navigate

      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (showInterest)
                  GestureDetector(
                    onTap: () {
                      if (title == 'VIP') {
                        _showVipBenefitsPopup(context!);
                      } else if (title == 'Premium') {
                        _showPremiumBenefitsPopup(context!);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Quyền Lợi',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            if (price != null) ...[
              const SizedBox(height: 8),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 16),
            ...features,
          ],
        ),
      ),
    );
  }

  Widget _buildFeature({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showVipBenefitsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quyền lợi gói VIP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFeature(
                  icon: Icons.check,
                  text: 'Sử dụng tất cả tính năng của User Bình Thường.'),
              _buildFeature(
                  icon: Icons.add_shopping_cart,
                  text: 'Tạo mall riêng và buôn bán các mặt hàng.'),
              _buildFeature(
                  icon: Icons.security,
                  text: 'Bảo hiểm đơn hàng - Buff Youtex.'),
              _buildFeature(
                  icon: Icons.account_circle,
                  text:
                      'Quản lý cửa hàng: Giá cả, chương trình khuyến mãi, doanh thu.'),
              _buildFeature(
                  icon: Icons.people_outline,
                  text: 'Quản lý nhân viên (giới hạn tối đa 10 tài khoản).'),
              _buildFeature(
                  icon: Icons.group, text: 'Tạo nhóm (tối đa 30 người/nhóm).'),
              _buildFeature(
                  icon: Icons.star,
                  text:
                      'Tham gia chương trình "Dấu chân Youtex" để xây dựng uy tín.'),
              _buildFeature(
                  icon: Icons.mark_email_read,
                  text:
                      'Hỗ trợ đăng bài quảng cáo cho mall: Team marketing hỗ trợ viết tối đa 2 bài PR/tháng.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  void _showPremiumBenefitsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quyền lợi gói Premium'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFeature(
                  icon: Icons.check, text: 'Tất cả quyền lợi của gói VIP.'),
              _buildFeature(
                  icon: Icons.security,
                  text: 'Bảo hiểm đơn hàng - Buff Youtex'),
              _buildFeature(
                  icon: Icons.post_add,
                  text: 'Hỗ trợ đăng bài quảng cáo (10 bài/tháng)'),
              _buildFeature(
                  icon: Icons.campaign, text: 'Hỗ trợ marketing cao cấp'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}

// Thay thế bằng một widget phù hợp cho dùng thử miễn phí
class FreeTrialTimeline extends StatelessWidget {
  const FreeTrialTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thời gian dùng thử')),
      body: const Center(
        child: Text('Thông tin về thời gian dùng thử ở đây!'),
      ),
    );
  }
}
