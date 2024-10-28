import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../../core/assets.dart';
import '../../../../../core/colors/color.dart';
import '../../../../widget_small/custom_button.dart';
import '../../../shopping_cart_page/payment_method_screen/payment_method_screen.dart';


class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

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
        leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back_ios,color: Styles.light,)),
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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Biệt danh (Alias) Dropdown
                const Text("Biệt danh", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: addressAlias,
                  items: const [
                    DropdownMenuItem(value: "Nhà riêng", child: Text("Nhà riêng")),
                    DropdownMenuItem(value: "Công ty", child: Text("Công ty")),
                    DropdownMenuItem(value: "Khác", child: Text("Khác")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      addressAlias = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                // Nhập địa chỉ chi tiết
                const Text("Địa chỉ chi tiết", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    hintText: "Vinhomes Grand Park, s103, Nguyễn Xiển",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
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
                    const Text("Đặt làm địa chỉ mặc định"),
                  ],
                ),
                const SizedBox(height: 16),
                // Nút thêm địa chỉ
                InkWell(
                  onTap: ()=>  Navigator.push(context, MaterialPageRoute(builder: (context) =>   const PaymentMethodScreen(),)),
                  child: const SizedBox(
                    width: double.infinity,
                    child: CusButton(text:"Thêm",color:Styles.blue),
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
