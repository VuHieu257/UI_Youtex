import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/bloc_seller/seller_register_product_bloc_bloc/seller_register_product_bloc_bloc.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/voucher/Voucher_seller_add.dart';

import '../../../../core/colors/color.dart';
import '../../../widget_small/appbar/custome_appbar_circle.dart';
import '../../../widget_small/text_form_field.dart';
import '../user_mail/profile_mall.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductaddScreen extends StatefulWidget {
  @override
  State<ProductaddScreen> createState() => _ProductaddScreenState();
}

class _ProductaddScreenState extends State<ProductaddScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

  String selectedGroup = 'May Mặc';
  String selectedRole = 'Hàng Mới';
  File? coverImageFile;
  File? additionalImageFile;

  Future<void> _pickCoverImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        coverImageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickAdditionalImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        additionalImageFile = File(pickedFile.path);
      });
    }
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
                    GestureDetector(
                      onTap: _pickCoverImage,
                      child: ImagePickerField(
                        label: "Hình ảnh bìa",
                        imageFile: coverImageFile,
                      ),
                    ),
                    GestureDetector(
                      // onTap: _pickAdditionalImage,
                      child: ImagePickerField(
                        label: "Hình ảnh/Video",
                        imageFile: additionalImageFile,
                      ),
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
        coverImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin và chọn ảnh")),
      );
      return;
    }

    // Tạo model ProductPostModel từ dữ liệu người dùng
    final productModel = ProductPostModel(
      name: productName,
      description: productDescription,
      images: [
        coverImageFile!.path,
        if (additionalImageFile != null) additionalImageFile!.path
      ],
      video: '',
      // Đặt giá trị industryId và categoryId từ lựa chọn của người dùng nếu có
      industryId: selectedGroup == 'May Mặc'
          ? 1
          : 2, // Điều chỉnh ID tùy theo loại hàng hóa
      categoryId:
          selectedRole == 'Hàng Mới' ? 1 : 2, // Điều chỉnh ID tùy theo danh mục
    );

    // Gửi sự kiện với ProductPostModel
    context.read<SellerRegisterProductBloc>().add(
          SellerRegisterProductPostEvent(model: productModel),
        );

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CardAddedSuccessDialog();
      },
    );
    Navigator.pop(context);
  }
}

class CustomTextFieldNoIcon extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int? line;

  const CustomTextFieldNoIcon({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.line,
  }) : super(key: key);

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

class ImagePickerField extends StatelessWidget {
  final String label;
  final File? imageFile;

  const ImagePickerField({Key? key, required this.label, this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Container(
          height: 200,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: imageFile != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    imageFile!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              : Center(
                  child: Icon(Icons.add_photo_alternate,
                      color: Colors.grey[500], size: 50),
                ),
        ),
      ],
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
