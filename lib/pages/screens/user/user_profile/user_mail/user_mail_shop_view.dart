import 'package:flutter/material.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_shop_analyst_view.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_mail/user_mail_shop_product.dart';
import 'package:ui_youtex/pages/screens/user/user_profile/user_profile_settings.dart';

class ShopOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E3799), Color(0xFF4A69BD)],
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
                    MaterialPageRoute(
                        builder: (context) => AccountSettingsScreen()),
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
            OrderStatusSection(),
            SalesOverviewSection(),
            SalesToolsSection(),
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
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Color(0xFF1E3799),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/images_users.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vải Hải Anh',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    Text(
                      ' Đơn hoàn tất 91.00%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              color: Colors.blue, size: 20),
          SizedBox(width: 8),
          Text(
            'Ví người bán',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          Spacer(),
          Text(
            '160.100.111 đ',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderStatusSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OrderStatusItem(
              icon: Icons.access_time,
              label: 'Chờ xác nhận',
              count: 14,
              color: Colors.orange,
            ),
            OrderStatusItem(
              icon: Icons.local_shipping_outlined,
              label: 'Chờ lấy hàng',
              color: Colors.blue,
            ),
            OrderStatusItem(
              icon: Icons.check_circle_outline,
              label: 'Đã giao',
              color: Colors.green,
            ),
            OrderStatusItem(
              icon: Icons.cancel_outlined,
              label: 'Đã hủy',
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}

class OrderStatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? count;
  final Color color;

  OrderStatusItem({
    required this.icon,
    required this.label,
    this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: color),
            ),
            if (count != null)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class SalesOverviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng quan bán hàng',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '7 ngày gần nhất',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              SalesOverviewCard(
                title: 'Doanh thu',
                value: '160.100K',
                backgroundColor: Color(0xFFE8F5E9),
                textColor: Colors.green,
              ),
              SalesOverviewCard(
                title: 'Số đơn hàng hoàn tất',
                value: '1.100',
                backgroundColor: Color(0xFFE3F2FD),
                textColor: Colors.blue,
              ),
              SalesOverviewCard(
                title: 'Lượt truy cập',
                value: '950',
                backgroundColor: Color(0xFFF3E5F5),
                textColor: Colors.purple,
              ),
              SalesOverviewCard(
                title: 'Số người mua',
                value: '1.960',
                backgroundColor: Color(0xFFFFF3E0),
                textColor: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SalesOverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final Color textColor;

  SalesOverviewCard({
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class SalesToolsSection extends StatelessWidget {
  final List<Map<String, dynamic>> tools = [
    {
      'icon': Icons.qr_code_2,
      'label': 'Mã giảm giá',
      'route': '/discountCodeScreen',
    },
    {
      'icon': Icons.inventory_2_outlined,
      'label': 'Kiểm tra hàng',
      'route': '/inventoryCheckScreen',
    },
    {
      'icon': Icons.payment_outlined,
      'label': 'Phương thức thanh toán',
      'route': '/paymentMethodScreen',
    },
    {
      'icon': Icons.local_shipping_outlined,
      'label': 'Đơn hàng vận chuyển',
      'route': '/shippingOrderScreen',
    },
    {
      'icon': Icons.production_quantity_limits,
      'label': 'Sản phẩm',
      'route': '/product_management',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalesAnalysisScreen()));
            },
            child: const Text(
              'Xem chi tiết phân tích bán hàng',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Styles.blue,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Công cụ bán hàng',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: tools.length,
                itemBuilder: (context, index) {
                  final tool = tools[index];
                  return SalesToolCard(
                    icon: tool['icon'],
                    label: tool['label'],
                    route: tool['route'],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SalesToolCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  SalesToolCard({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: Colors.blue),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
