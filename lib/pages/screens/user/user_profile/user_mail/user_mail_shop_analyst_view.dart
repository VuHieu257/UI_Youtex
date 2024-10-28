import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../../core/colors/color.dart';

class SalesAnalysisScreen extends StatelessWidget {
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
          'Phân tích bán hàng',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Styles.light,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for date range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng quan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: '30 Ngày gần nhất',
                  items: [
                    DropdownMenuItem(
                      value: '30 Ngày gần nhất',
                      child: Text('30 Ngày gần nhất'),
                    ),
                    DropdownMenuItem(
                      value: '7 Ngày gần nhất',
                      child: Text('7 Ngày gần nhất'),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
            SizedBox(height: 16),

            // Grid for metrics
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildMetricCard('Lượt truy cập', '1.600', 'Tăng 12%',
                      Colors.green[100], Colors.green),
                  buildMetricCard('Số đơn hàng hoàn tất', '1.980', 'Giảm 20%',
                      Colors.red[100], Colors.red),
                  buildMetricCard('Doanh thu', '160.100K', 'Tăng 10%',
                      Colors.green[100], Colors.green),
                  buildMetricCard('Số người mua', '1.200', 'Không đổi',
                      Colors.orange[100], Colors.orange),
                  buildMetricCard('Chờ xác nhận', '200', 'Tăng 10%',
                      Colors.green[100], Colors.green),
                  buildMetricCard('Chờ lấy hàng', '3', 'Tăng 10%',
                      Colors.green[100], Colors.green),
                  buildMetricCard('Khiếu nại', '2', 'Tăng 2.00%',
                      Colors.red[100], Colors.red),
                  buildMetricCard('Đang hoàn', '0', 'Không đổi',
                      Colors.orange[100], Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build each metric card
  Widget buildMetricCard(String title, String value, String status,
      Color? bgColor, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(
                status.contains('Tăng')
                    ? Icons.trending_up
                    : Icons.trending_down,
                color: iconColor,
              ),
              SizedBox(width: 8),
              Text(
                status,
                style: TextStyle(color: iconColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
