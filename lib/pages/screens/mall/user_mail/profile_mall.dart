import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc_seller/bloc_seller_register_status_bloc.dart/seller_register_status_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_bloc/seller_register_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_register_bloc/seller_register_event.dart';
import 'package:ui_youtex/core/model/store.info.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_employee.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_view.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import '../../../widget_small/appbar/cus_appbar_background.dart';
import '../user_mail_settings/mail_infor_view.dart';

class SellerStatusPage extends StatefulWidget {
  const SellerStatusPage({Key? key}) : super(key: key);

  @override
  State<SellerStatusPage> createState() => _SellerStatusPageState();
}

class _SellerStatusPageState extends State<SellerStatusPage> {
  @override
  void initState() {
    super.initState();
    // Trigger lấy status ngay khi vào trang
    context.read<SellerRegisterStatusBloc>().add(GetSellerStatusEvent());
  }

  void _showErrorDialog(String title, String message,
      {bool isSuccess = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSuccess ? Colors.green : Colors.red, // Success/Error color
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              if (!isSuccess) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const MallInfoScreen(),
                  ),
                );
              }
            },
            child: const Text(
              'Đồng ý',
              style: TextStyle(color: Colors.blue), // Color for button text
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            BlocConsumer<SellerRegisterStatusBloc, SellerRegisterStatusState>(
          listener: (context, state) {
            if (state is SellerRegisterStatusError) {
              _showErrorDialog('Thông Báo', state.message);
            }
          },
          builder: (context, state) {
            if (state is SellerRegisterStatusLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Đang kiểm tra trạng thái...',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            } else if (state is SellerRegisterStatusSuccess) {
              // Delay một chút để hiển thị animation loading
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) =>
                        const ShopOverviewScreen(), // Trang thành công
                  ),
                );
              });

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Đang chuyển trang...',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            // Initial state hoặc các state khác
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

// LoadingIndicator Widget riêng để tái sử dụng
class LoadingIndicator extends StatelessWidget {
  final String message;

  const LoadingIndicator({
    Key? key,
    this.message = 'Đang xử lý...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.3),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 24.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserMailDetailsShop extends StatelessWidget {
  const UserMailDetailsShop({super.key});

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
                  UserStorageHeader(storeInfo: state.storeInfo),
                  const WalletCard(),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Cài đặt",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SettingsList(),
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

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            '0 đ',
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
                      builder: (context) => const SellerStatusPage()));
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

  const SettingsItem(
      {super.key, required this.icon, required this.text, required this.onTap});

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
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 12), // Tăng padding
        child: Row(
          children: [
            Icon(icon, color: Styles.nearPrimary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold), // Tăng font chữ
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
                    Navigator.pop(context);
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
                child: const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      Asset.bgImageAvatar,
                    )),
              ),
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
                              fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,
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
