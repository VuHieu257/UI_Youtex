import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/splash/Welcome/Register/login_screen.dart';

class MembershipPaymentScreen extends StatelessWidget {
  const MembershipPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Membership Package Payment',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 25, vertical: 20), // Padding tổng thể
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary Section
            const Text(
              "Order Summary",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600, // Tăng độ đậm của chữ
                color: Colors.black87, // Màu chữ đậm hơn một chút
              ),
            ),
            const SizedBox(height: 15), // Tăng khoảng cách để thoáng hơn
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Provisional",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700]), // Font chữ nhỏ và màu xám
                ),
                Text(
                  "400\$",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const Text(
                  "0\$",
                  style: TextStyle(fontSize: 16, color: Styles.blue),
                ),
              ],
            ),
            const Divider(height: 30, thickness: 1),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Font lớn hơn cho phần tổng
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "400\$",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Payment Method Section
            const Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PaymentMethodButton(
                  icon: Icons.credit_card,
                  label: "Card",
                  color: const Color(0xFF1F96F2), // Light blue-ish color
                  onPressed: () {},
                ),
                PaymentMethodButton(
                  icon: Icons.attach_money,
                  label: "Cash",
                  color: const Color(0xFF1F96F2), // Light gray color
                  onPressed: () {},
                ),
                PaymentMethodButton(
                  icon: Icons.apple,
                  label: "Apple Pay",
                  color: const Color(0xFF1F96F2), // Light gray color
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(
                height:
                    25), // Khoảng cách giữa phần phương thức thanh toán và thẻ
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5), // Tăng padding để thoáng hơn
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    Asset.iconVisa,
                    height: 100,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "**** **** **** 2512",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context, '/PaymentMethodPayScreen');
                      // Xử lý chỉnh sửa thẻ
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Buy Package Button
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
                onPressed: () async {
                  // Hiển thị dialog
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomDialog(
                        title: 'Thành công',
                        message: 'Mua thành công',
                      );
                    },
                  );
                  // Khi dialog bị đóng, chuyển sang trang mới
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const LoginScreen(), // Trang bạn muốn chuyển tới
                    ),
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
                  'Buy Package',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Payment Info Text
            Center(
              child: Text(
                "Payment will be charged to your account. Your\nmembership will auto-renew at the end of each\nperiod until you cancel.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14), // Font chữ nhỏ hơn và màu xám
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Widget for Payment Method Buttons
class PaymentMethodButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const PaymentMethodButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 20), // Điều chỉnh padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(icon, color: Styles.light),
      label: Text(
        label,
        style: const TextStyle(
            color: Styles.light,
            fontWeight: FontWeight.bold), // Font chữ đậm cho nhãn
      ),
      onPressed: onPressed,
    );
  }
}
