import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../../core/assets.dart';
import '../../../../../core/colors/color.dart';
import '../../../../widget_small/custom_button.dart';
import '../../../shopping_cart_page/payment_method_screen/payment_method_screen.dart';


class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isDefault = false;
  String addressAlias = 'Nhà riêng'; // Giá trị mặc định cho dropdown
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),child: Icon(Icons.arrow_back_ios,color: Styles.light,)),
        title: Text('Thêm Địa Chỉ',style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
      ),
      body: Column(
        children: [
          // Thay thế bản đồ bằng hình ảnh
          Expanded(
            child:                     Image.asset(Asset.bgMap,),

          ),
          // Form nhập địa chỉ
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Biệt danh (Alias) Dropdown
                Text("Biệt danh", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: addressAlias,
                  items: [
                    DropdownMenuItem(child: Text("Nhà riêng"), value: "Nhà riêng"),
                    DropdownMenuItem(child: Text("Công ty"), value: "Công ty"),
                    DropdownMenuItem(child: Text("Khác"), value: "Khác"),
                  ],
                  onChanged: (value) {
                    setState(() {
                      addressAlias = value!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // Nhập địa chỉ chi tiết
                Text("Địa chỉ chi tiết", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Vinhomes Grand Park, s103, Nguyễn Xiển",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // Đặt làm địa chỉ mặc định Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: isDefault,
                      onChanged: (bool? value) {
                        setState(() {
                          isDefault = value ?? false;
                        });
                      },
                    ),
                    Text("Đặt làm địa chỉ mặc định"),
                  ],
                ),
                SizedBox(height: 16),
                // Nút thêm địa chỉ
                InkWell(
                  onTap: ()=>  Navigator.push(context, MaterialPageRoute(builder: (context) =>   PaymentMethodScreen(),)),
                  child: SizedBox(
                    width: double.infinity,
                    child: const CusButton(text:"Thêm",color:Styles.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
