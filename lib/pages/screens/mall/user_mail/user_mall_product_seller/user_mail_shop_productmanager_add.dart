import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/bloc_seller/seller_register_product_bloc_bloc/seller_register_product_bloc_bloc.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_view.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mall_product_seller/user_mail_shop_product.dart';

import '../../../../../core/colors/color.dart';
import '../../../../widget_small/appbar/custome_appbar_circle.dart';

class ProductaddScreen extends StatefulWidget {
  const ProductaddScreen({super.key});

  @override
  State<ProductaddScreen> createState() => _ProductaddScreenState();
}

class _ProductaddScreenState extends State<ProductaddScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

  String selectedGroup = 'May Mặc';
  String selectedRole = 'Hàng Mới';
  List<File> productImages = [];

  Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        final newImages = pickedFiles.map((e) => File(e.path)).toList();
        if (productImages.length + newImages.length > 6) {
          _showMessage('Lỗi', 'Chỉ được chọn tối đa 6 ảnh');
          return;
        }
        productImages.addAll(newImages);
      });
    }
  }

  void _showMessage(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(message),
          ],
        ),
        backgroundColor: title == 'Thành Công' ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: cusAppBarCircle(context, title: "Thêm Sản Phẩm"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    CustomTextFieldNoIcon(
                      controller: _productNameController,
                      label: "Tên Sản phẩm",
                      hintText: "Điền thông tin tại đây",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hình ảnh sản phẩm (1-6 ảnh)",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              if (productImages.length < 6)
                                GestureDetector(
                                  onTap: _pickImages,
                                  child: Container(
                                    width: 150,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add_photo_alternate,
                                          color: Colors.grey[500], size: 50),
                                    ),
                                  ),
                                ),
                              ...productImages.asMap().entries.map((entry) {
                                return Stack(
                                  children: [
                                    Container(
                                      width: 150,
                                      margin: const EdgeInsets.only(right: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          entry.value,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 13,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            productImages.removeAt(entry.key);
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _buildDropdownSection(
                        "Loại hàng hóa", selectedGroup, ['May Mặc', 'Điện Tử'],
                        (value) {
                      setState(() {
                        selectedGroup = value!;
                      });
                    }),
                    _buildDropdownSection(
                        "Danh mục", selectedRole, ['Hàng Mới'], (value) {
                      setState(() {
                        selectedRole = value!;
                      });
                    }),
                    CustomTextFieldNoIcon(
                      controller: _productDescriptionController,
                      label: "Chi Tiết",
                      hintText: "Điền thông tin tại đây",
                      line: 7,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _onSubmit,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Xác Nhận',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSection(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        _buildDropdownButton(value: value, items: items, onChanged: onChanged),
      ],
    );
  }

  Future<void> _onSubmit() async {
    final productName = _productNameController.text;
    final productDescription = _productDescriptionController.text;

    if (productName.isEmpty ||
        productDescription.isEmpty ||
        productImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Vui lòng nhập đầy đủ thông tin và chọn ảnh")),
      );
      return;
    }

    final productModel = ProductPostModel(
      name: productName,
      description: productDescription,
      images: productImages.map((file) => file.path).toList(),
      video: '',
      industryId: selectedGroup == 'May Mặc' ? 1 : 2,
      categoryId: selectedRole == 'Hàng Mới' ? 1 : 2,
    );

    context.read<SellerRegisterProductBloc>().add(
          SellerRegisterProductPostEvent(model: productModel),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showMessage('Thành Công', 'Tạo sản phẩm  thành công!');
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShopOverviewScreen()));
  }
}

class CustomTextFieldNoIcon extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int? line;

  const CustomTextFieldNoIcon({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.line,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              controller: controller,
              maxLines: line,
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDropdownButton({
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 4),
          blurRadius: 4,
        ),
      ],
    ),
    child: DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Styles.colorF9F9F9,
      ),
      dropdownColor: Styles.colorF9F9F9,
      value: value,
      isExpanded: true,
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
      icon: const Icon(Icons.arrow_drop_down),
    ),
  );
}
