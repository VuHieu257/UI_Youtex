import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/colors/color.dart';
import '../../widget_small/custom_button.dart';

class NamePangage extends StatefulWidget {
  @override
  _FanPageManagementState createState() => _FanPageManagementState();
}

class _FanPageManagementState extends State<NamePangage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Styles.light,)),
        title: Text(
          'Trang', style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
      ),
      body: _buildCreatePage(),
    );
  }

  Widget _buildCreatePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trang bạn quản lý',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Hãy dùng tên doanh nghiệp/ thương hiệu/tổ chức của bạn hoặc tên góp phần giải thích về Trang',
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Tên trang',
              border: OutlineInputBorder(),
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: const CusButton(text: "Tiếp", color: Styles.blue),
          ),
        ],
      ),
    );
  }


}