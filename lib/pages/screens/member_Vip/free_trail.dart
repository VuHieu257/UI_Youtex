import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_vip.dart';

import '../../../core/assets.dart';
import '../../widget_small/bottom_navigation/bottom_navigation.dart';

class FreeTrialTimeline extends StatefulWidget {
  const FreeTrialTimeline({super.key});

  @override
  State<FreeTrialTimeline> createState() => _FreeTrialTimelineState();
}

class _FreeTrialTimelineState extends State<FreeTrialTimeline> {
  String _selectedPaymentMethod = 'Thẻ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6DA7FF),
                Color(0xFFDAF5FF),
                Color(0xFFDAF5FF),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
            ),
          ),
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
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Bản dùng thử miễn phí của\nbạn hoạt động như thế nào',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    _buildTimelineItem(
                      icon: Icons.lock_open,
                      title: 'Hôm nay',
                      description:
                          'Mở khóa quyền truy cập vào tất cả các tính năng cao cấp',
                      isFirst: true,
                    ),
                    _buildTimelineItem(
                      icon: Icons.notifications_none,
                      title: 'Day 5',
                      description:
                          'Nhận lời nhắc rằng thời gian dùng thử của bạn sắp kết thúc',
                    ),
                    _buildTimelineItem(
                      icon: Icons.star_border,
                      title: 'Day 7',
                      description:
                          'Đăng ký của bạn bắt đầu. Hủy bất cứ lúc nào trước',
                      isLast: true,
                    ),
                    const SizedBox(height: 20), // Thay Spacer() bằng SizedBox
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Truy cập miễn phí trong 7 ngày, sau đó là',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Text(' 10.990.000 đồng/năm',
                              textAlign: TextAlign.center,
                              style: context.theme.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
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
                          showPaymentMethodSheet(context);
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return const CardAddedSuccessDialog();
                          //   },
                          // );
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
                          'Bắt đầu dùng thử miễn phí 7 ngày',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PremiumUnlockScreen()));
                        },
                        child: const Text(
                          'Xem gói thành viên',
                          style: TextStyle(
                            color: Color(0xFF2196F3),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CustomNavBar()));
                        },
                        child: const Text(
                          'Bỏ qua',
                          style: TextStyle(
                            color: Color(0xFF2196F3),
                            fontSize: 16,
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

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    required String description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 30),
              ),
              Expanded(
                child: Container(
                  width: 12,
                  margin: const EdgeInsets.symmetric(vertical: 0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF2196F3),
                        const Color(0xFF2196F3).withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: isLast ? 40 : 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void showPaymentMethodSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const PaymentMethodBottomSheet(),
    );
  }
}
