import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/colors/color.dart';
import '../../widget_small/custom_button.dart';

class Fanpage extends StatelessWidget {
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
      body: Column(
        children: [
          // Thanh nút điều hướng
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                ElevatedButton(
                  onPressed: () {},
                   child: Text('Tạo',style: TextStyle(color: Colors.black),),


                ),

                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                   child: Text('Khám phá',style: TextStyle(color: Colors.black),),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Trang đã thích',style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black, // Màu của đường gạch ngang
            thickness: 1, // Độ dày của đường gạch ngang
            height: 10, // Khoảng cách giữa đường và các phần tử trên/dưới
          ),

Row(
  mainAxisAlignment:MainAxisAlignment.start ,
  children: [
    const Text('Trang bạn quản lý',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
  ],
),
          SizedBox(height: 10,),
          // Danh sách trang quản lý
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Số lượng trang
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.pets), // Biểu tượng trang
                  title: Text('You Textile'),
                  trailing: Icon(Icons.more_vert), // Nút hành động thêm
                  onTap: () {
                    // Hành động khi nhấn vào trang
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}