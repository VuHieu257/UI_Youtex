import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_bloc/seller_register_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_bloc/seller_register_event.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/model/store.info.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/profile_mall.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_analyst_view.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/constants.dart';

import '../../../../core/assets.dart';
import '../../../widget_small/appbar/cus_appbar_background.dart';
import '../user_mail_settings/mail_infor_view.dart';

class ShopOverviewScreen extends StatelessWidget {
  const ShopOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellerRegisterBloc(
        restfulApiProvider: RestfulApiProviderImpl(),
      )..add(const LoadStoreInfo()),
      child: Scaffold(
        body: BlocBuilder<SellerRegisterBloc, SellerRegisterState>(
          builder: (context, state) {
            if (state is SellerRegisterLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SellerRegisterLoaded) {
              return Column(
                children: [
                  UserStorageHeader(
                      storeInfo: state
                          .storeInfo), // Truyền storeInfo vào UserInfoHeader
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const WalletCard(),
                          const OrderStatusSection(),
                          const SalesOverviewSection(),
                          SalesToolsSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is SellerRegisterFailure) {
              return Center(child: Text('Lỗi: ${state.error}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class UserStorageHeader extends StatelessWidget {
  final StoreInfo storeInfo; // Nhận dữ liệu từ StoreInfo
  const UserStorageHeader({super.key, required this.storeInfo});
  @override
  Widget build(BuildContext context) {
    return cusAppBarBackground(
      context,
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserMailDetailsShop(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Styles.colorF9F9F9.withOpacity(0.5)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Styles.light,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MallInfoScreen()),
                    );
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Styles.greyLight.withOpacity(0.5),
                    child: const Icon(Icons.settings_suggest_outlined,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MallInfoScreen()),
                    );
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Styles.greyLight.withOpacity(0.5),
                    child: const Icon(Icons.notifications_none,
                        color: Colors.white),
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
                  margin: const EdgeInsets.only(left: 10),
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
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: storeInfo.imagePath?.isEmpty ?? true
                        ? const AssetImage(Asset.bgImageAvatar)
                        : NetworkImage(
                            "${NetworkConstants.urlImage}${storeInfo.imagePath}",
                            scale: 1.0,
                          ) as ImageProvider,
                  )),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(storeInfo.name,
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Phone',
                          style: context.theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Text(
                        storeInfo.phone,
                        style: context.theme.textTheme.titleMedium?.copyWith(
                            color: Styles.color73FF83,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Mail\t\t',
                          style: context.theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          storeInfo.email,
                          style: context.theme.textTheme.titleMedium?.copyWith(
                              color: Styles.colorFF6B6B,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
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
        color: Styles.colorF3F3F3,
        borderRadius: BorderRadius.circular(12), // Tăng độ bo tròn
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 3,
            offset: const Offset(0, 4),
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
            '0 đ',
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
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
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
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => OrderManagementScreen()));
                // },
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
      ],
    );
  }
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
            fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.bold),
      ),
    ],
  );
}

class OrderStatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? count;
  final Color color;

  const OrderStatusItem({
    super.key,
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Tổng quan bán hàng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '7 ngày gần nhất',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
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
                backgroundColor: Color(0xFFEFFFEC),
                textColor: Colors.green,
                icon: Icons.arrow_circle_up,
                iconColor: Colors.green,
              ),
              SalesOverviewCard(
                title: 'Số đơn hàng hoàn tất',
                value: '1.100',
                backgroundColor: Color(0xFFFFD0D0),
                textColor: Colors.pink,
                icon: Icons.arrow_circle_down,
                iconColor: Colors.red,
              ),
              SalesOverviewCard(
                title: 'Lượt truy cập',
                value: '950',
                backgroundColor: Color(0xFFF3E5F5),
                textColor: Colors.purple,
                icon: Icons.arrow_circle_up,
                iconColor: Colors.green,
              ),
              SalesOverviewCard(
                title: 'Số người mua',
                value: '1.960',
                backgroundColor: Color(0xFFFFF3E0),
                textColor: Colors.orange,
                icon: Icons.remove_circle_outline_outlined,
                iconColor: Colors.orange,
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
  final IconData icon;
  final Color iconColor;

  const SalesOverviewCard({
    super.key,
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
              const SizedBox(
                width: 10,
              ),
              Icon(
                icon,
                color: iconColor,
              ),
            ],
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SalesAnalysisScreen()));
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
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
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
        ),
      ],
    );
  }
}

class SalesToolCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  const SalesToolCard({
    super.key,
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
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.25))
                ]),
            child: Icon(icon, size: 24, color: Colors.blue),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 40,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
