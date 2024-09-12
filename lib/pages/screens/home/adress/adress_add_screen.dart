import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';

import '../../../../core/assets.dart';

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
        title: Text('Thêm địa chỉ'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Thực hiện logic thêm địa chỉ tại đây
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text("Thêm"),
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
