import 'package:flutter/material.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/assets.dart';
class DetailArticle extends StatelessWidget {
  const DetailArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bài viết',style: context.theme.textTheme.headlineLarge?.copyWith(
          color: Styles.nearPrimary
        ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(Asset.bgCustomer1),
                ),
                const SizedBox(width: 10,),
                Text(
                  'Đồng phục Hải Anh',
                  style: context.theme.textTheme.headlineSmall?.copyWith(
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                'Thứ Bảy, ngày 12 tháng 10 năm 2024',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            SizedBox(height: 16),
            const Align(
              alignment: Alignment.center,
              child:      Text(
                'KHAI TRƯƠNG CHI NHÁNH MỚI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),
            Container(
              height: 150,
              width: context.width*0.8,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(Asset.bgCustomer5),fit: BoxFit.contain)
              ),
            ),
            // Image.asset(Asset.bgCustomer5, fit: BoxFit.contain, height: 150,width: context.width*0.8,),
            const SizedBox(height: 8),
            const Text(
              'Việc Vietbank mở chi nhánh tại Kiên Giang nhằm tăng cường mạng lưới kinh doanh, mở rộng thị phần, cung cấp đa dạng sản phẩm cho khách hàng.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(
                  width: 200,
                  child: Text(
                    'Ngân hàng TMCP Việt Nam Thương Tín (Vietbank) vừa đưa vào hoạt động chi nhánh Kiên Giang hôm 24/9 tại số 164-166-168 Trần Phú, phường Vĩnh Thanh Vân, TP. Rạch Giá, tỉnh Kiên Giang.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(image: AssetImage(Asset.bgCustomer5),fit: BoxFit.cover)
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            const Text(
              'Chi nhánh này sẽ cung cấp dịch vụ cho vay, tiền gửi, thanh toán trong nước, quốc tế, và các dịch vụ ngân hàng tiện ích khác.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}