import 'package:flutter/material.dart';

class ShopOverviewScreen extends StatelessWidget {
  const ShopOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3799),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UserInfoHeader(),
            const WalletCard(),
            const OrderStatusSection(),
            const SalesOverviewSection(),
            SalesToolsSection(),
          ],
        ),
      ),
    );
  }
}

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: const BoxDecoration(
        color: Color(0xFF1E3799),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/images_users.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
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
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Row(
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
  const OrderStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
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

  const OrderStatusItem({super.key, 
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
              padding: const EdgeInsets.all(8),
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
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class SalesOverviewSection extends StatelessWidget {
  const SalesOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
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
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: const [
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

  const SalesOverviewCard({super.key, 
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
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

  SalesToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Công cụ bán hàng',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}

class SalesToolCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const SalesToolCard({super.key, 
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
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: Colors.blue),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
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
