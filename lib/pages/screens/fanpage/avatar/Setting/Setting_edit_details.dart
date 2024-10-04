import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../../core/colors/color.dart';
import '../../../../widget_small/custom_button.dart';

class EditDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Styles.light,)),
        title: Text(
          'Chỉnh Sửa Chi Tiết', style: context.theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Địa chỉ', 'Gia Lâm, Hà Nội'),
            _buildDetailRow('Số điện thoại', '22/02/1999'),
            _buildDetailRow('Hoạt động', 'Mở cửa: 8:00 - 17:00 hàng ngày'),
            _buildDetailRow('Xếp hạng', '4.5 (281 lượt đánh giá)'),
            _buildDetailRow('Ngày tạo', '28 tháng 6, 2024'),
            _buildDetailRow('Email', 'youtextile@gmail.com'),

          ],
        ),
      ),
      bottomNavigationBar:
    SizedBox(
    width: context.width*0.2,
      height: context.width*0.2,
      child: const CusButton(text: "Lưu Thông Tin", color: Styles.blue),
    ),
    );

  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  label,
                  style: TextStyle(
                    color: Styles.grey,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  value,
                  style: TextStyle(
                    color: Styles.dark,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider( // Thêm Divider dưới mỗi row
          color: Colors.grey[0], // Màu của đường viền
          thickness: 1, // Độ dày của đường viền
        ),
      ],
    );
  }
}