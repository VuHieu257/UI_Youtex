import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/util/show_snack_bar.dart';

import '../../../../bloc/login_bloc/login_bloc.dart';
import '../../home/product/adress/adress_screen.dart';
import '../edit_profile/edit_profile_screen.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            // Handle back action
          },
        ),
        title: const Text(
          'Thiết lập tài khoản',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: Tài khoản
              const Text(
                'Tài khoản',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSettingItem('Tài khoản & bảo mật', Icons.security, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ));
              }),
              _buildSettingItem('Địa chỉ', Icons.location_on, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddressScreen(),
                    ));
              }),
              _buildSettingItem(
                  'Tài khoản/Thẻ ngân hàng', Icons.credit_card, () {}),
              _buildSettingItem('Quốc gia: 🇻🇳 Vietnam', Icons.flag, () {}),
              _buildSettingItem(
                  'Cài đặt thông báo', Icons.notifications, () {}),

              const SizedBox(height: 20),

              // Section: Hỗ trợ
              const Text(
                'Hỗ trợ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSettingItem('Trung tâm hỗ trợ', Icons.headset_mic, () {}),
              _buildSettingItem('Tiêu chuẩn cộng đồng', Icons.group, () {}),
              _buildSettingItem(
                  'Điều khoản của ứng dụng', Icons.description, () {}),
              _buildSettingItem(
                  'Yêu cầu xóa tài khoản', Icons.delete_forever, () {}),

              const SizedBox(height: 40),

              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LogoutLoading) {
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LogoutSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (Route<dynamic> route) => false,
                    );
                  } else if (state is LogoutFailure) {
                    SnackBarUtils.showWarningSnackBar(context,
                        message: state.error);
                  }
                },
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      context.read<LoginBloc>().add(LogoutButtonPressed());
                    },
                    child: const Text(
                      'Đăng xuất tài khoản',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, top: 4),
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
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
