import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/colors/color.dart';
import '../../widget_small/custom_button.dart';

class FanpageDescription extends StatefulWidget {
  const FanpageDescription({super.key});

  @override
  _FanPageManagementState createState() => _FanPageManagementState();
}

class _FanPageManagementState extends State<FanpageDescription>
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
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thêm mô tả',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Hãy mô tả nhóm của bạn để mọi người biết nhóm xoay quanh chủ đề gì.',
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Mô tả về cộng đồng của bạn',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: CusButton(text: "Tiếp", color: Styles.blue),
          ),
        ],
      ),
    );
  }


}