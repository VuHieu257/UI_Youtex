import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../core/colors/color.dart';

class Fanpage extends StatelessWidget {
  const Fanpage({super.key});

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
                   child: const Text('Tạo',style: TextStyle(color: Colors.black),),


                ),

                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                   child: const Text('Khám phá',style: TextStyle(color: Colors.black),),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Trang đã thích',style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black, // Màu của đường gạch ngang
            thickness: 1, // Độ dày của đường gạch ngang
            height: 10, // Khoảng cách giữa đường và các phần tử trên/dưới
          ),

const Row(
  mainAxisAlignment:MainAxisAlignment.start ,
  children: [
    Text('Trang bạn quản lý',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
  ],
),
          const SizedBox(height: 10,),
          // Danh sách trang quản lý
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Số lượng trang
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.pets), // Biểu tượng trang
                  title: const Text('You Textile'),
                  trailing: const Icon(Icons.more_vert), // Nút hành động thêm
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