import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/colors/color.dart';
import '../../widget_small/custom_button.dart';

class Fanpage_infor extends StatelessWidget {
  const Fanpage_infor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Styles.light,
            )),
        title: Text(
          'Trang',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Styles.light,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hoàn tất thiết lập Trang của bạn',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              const Text(
                'Thành công rồi! Hãy bổ sung thông tin chi tiết ngay để mọi người dễ dàng kết nối với bạn nhé.',
              ),
              const SizedBox(height: 16),
              const SectionTitle(icon: Icons.info, title: 'Chung'),
              const CustomTextField(
                hintText: 'Tiểu sử',
                label: '',
              ),
              Text(
                'Mô tả về trang của bạn',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Styles.grey,
                ),
              ),
              const SizedBox(height: 16),
              const SectionTitle(
                  icon: Icons.contact_mail, title: 'Thông tin liên hệ'),
              const CustomTextField(
                hintText: 'Email',
                label: '',
              ),
              const CustomTextField(
                hintText: 'Số điện thoại',
                label: '',
              ),
              const SizedBox(height: 16),
              const SectionTitle(icon: Icons.location_on, title: 'Vị trí'),
              const CustomTextField(
                hintText: 'Địa chỉ',
                label: '',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: context.width * 0.2,
        height: context.width * 0.2,
        child: const CusButton(text: "Tạo Nhóm", color: Styles.blue),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionTitle({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;

  const CustomTextField({required this.hintText, required String label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
