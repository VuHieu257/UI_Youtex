import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../../core/colors/color.dart';
import '../../../widget_small/appbar/custome_appbar_circle.dart';

class SalesAnalysisScreen extends StatelessWidget {
  const SalesAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cusAppBarCircle(context,title: "Phân tích bán hàng"),
            const Text(
              'Tổng quan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin:const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9), // Màu nền
                borderRadius: BorderRadius.circular(15), // Bo góc
                boxShadow:[
                  BoxShadow(offset: const Offset(0, 4),color: Colors.black.withOpacity(0.25),blurRadius: 4)
                ]
              ),
              child: Row(
                children: [
                   const Icon(Icons.insert_chart_outlined,size: 30,color: Styles.nearPrimary,),
                  const SizedBox(width: 10,),
                  DropdownButton<String>(
                    value: '30 Ngày gần nhất',
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey), // Màu của mũi tên
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: '30 Ngày gần nhất',
                        child: Text('30 Ngày gần nhất'),
                      ),
                      DropdownMenuItem(
                        value: '7 Ngày gần nhất',
                        child: Text('7 Ngày gần nhất'),
                      ),
                    ],
                    onChanged: (value) {
                      // Xử lý khi chọn một tùy chọn
                    },
                    dropdownColor: Color(0xFFF9F9F9), // Màu nền cho menu thả xuống
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("Chỉ số",style: context.theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),),
                const Spacer(),
                Text("Chọn 4/8",style: context.theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                childAspectRatio: 1.1,
                children: [
                  buildMetricCard('Lượt truy cập', '1.600', 'Tăng 12%',
                      Styles.colorEFFFEC, Colors.green),
                  buildMetricCard('Số đơn hàng hoàn tất', '1.980', 'Giảm 20%',
                      Colors.red[100], Colors.red),
                  buildMetricCard('Doanh thu', '160.100K', 'Tăng 10%',
                      Styles.colorEFFFEC, Colors.green),
                  buildMetricCard('Số người mua', '1.200', 'Không đổi',
                      Colors.orange[100], Colors.orange),
                  buildMetricCard('Chờ xác nhận', '200', 'Tăng 10%',
                      Styles.colorEFFFEC, Colors.green),
                  buildMetricCard('Chờ lấy hàng', '3', 'Tăng 10%',
                      Styles.colorEFFFEC, Colors.green),
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
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color:Colors.black.withOpacity(0.25)
            )
          ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10,),
          Text(
            value,
            style:  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Styles.nearPrimary ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Icon(
                status.contains('Tăng')
                    ? Icons.trending_up
                    :status.contains('Giảm')
                    ? Icons.trending_down
                    :Icons.remove,
                color: iconColor,
              ),
              const SizedBox(width: 8),
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
