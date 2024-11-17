import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/bloc_seller/seller_product_Shiping_bloc_bloc/seller_product_extra_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_Shiping_bloc_bloc/seller_product_extra_bloc_event.dart';
import 'package:ui_youtex/bloc_seller/seller_product_Shiping_bloc_bloc/seller_product_extra_bloc_state.dart';
import 'package:ui_youtex/bloc_seller/seller_product_extra_bloc_bloc/seller_product_extra_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_extra_bloc_bloc/seller_product_extra_bloc_event.dart';
import 'package:ui_youtex/bloc_seller/seller_product_extra_bloc_bloc/seller_product_extra_bloc_state.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_event.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_state.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mall_product_seller/user_mail_shop_product.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';

class ProductActiveShipingScreen extends StatefulWidget {
  final String? productId;
  const ProductActiveShipingScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductActiveShipingScreen> createState() =>
      _ProductActiveScreenState();
}

class _ProductActiveScreenState extends State<ProductActiveShipingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  // Sửa giá trị mặc định phù hợp với items trong dropdown
  String selectedGender = '20x20x20';

  String? sizeChartPath;

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  String mapGenderToApiValue(String vietnameseGender) {
    switch (vietnameseGender) {
      case '20x20x20':
        return '20x20x20';
      case '20x40x20':
        return '20x40x20';
      default:
        return '20x20x20';
    }
  }

  void _saveData(BuildContext context) {
    // Converting the weight from String to int
    final int? weightValue = int.tryParse(weightController.text);

    final productShiping = UpdateSellerProductShipingEvent(
      productId: widget.productId ?? '', // Use an empty string as the default
      dimension: mapGenderToApiValue(selectedGender),
      weight: weightValue, // Using the parsed int value
    );

    context.read<SellerProductShipingBloc>().add(productShiping);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomTextFieldNoIcon(
        controller: controller,
        label: label,
        hintText: hintText,
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF218FF2), Color(0xFF13538C)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : () => _saveData(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            : const Text(
                'Lưu thay đổi',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
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
            child: cusAppBarCircle(context, title: "Thông tin Shiping"),
          ),
          Expanded(
            child: BlocConsumer<SellerProductShipingBloc,
                SellerProductShipingState>(
              listener: (context, state) {
                if (state is SellerProductShipingSuccess) {
                  // Hiển thị dialog thành công
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: 'Thành Công',
                        message: state.message,
                      );
                    },
                  ).then((_) {
                    // Sau khi dialog đóng, điều hướng đến ProductManagementScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductManagementScreen()),
                    );
                  });
                } else if (state is SellerProductShipingError) {
                  // Hiển thị dialog lỗi
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: 'Thông báo',
                        message: state.error,
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          _buildDropdownSection(
                            "Kích Thước",
                            selectedGender,
                            [
                              '20x20x20',
                              '20x40x20',
                            ],
                            (value) {
                              if (value != null) {
                                setState(() {
                                  selectedGender = value;
                                });
                              }
                            },
                          ),
                          _buildTextField(
                            controller: weightController,
                            label: "Trọng lượng",
                            hintText: "Điền thông tin tại đây",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Vui lòng nhập số lượng';
                              }
                              if (int.tryParse(value!) == null) {
                                return 'Vui lòng nhập số nguyên';
                              }
                              return null;
                            },
                          ),
                          _buildSubmitButton(
                              state is SellerProductShipingLoading),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSection(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
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
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down),
      ),
    );
  }
}

class CustomTextFieldNoIcon extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;

  const CustomTextFieldNoIcon({
    Key? key,
    required this.hintText,
    required this.label,
    required this.controller,
    required TextInputType keyboardType,
    required String? Function(String? p1) validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Container(
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
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                hintText: hintText,
                filled: true,
                fillColor: Styles.colorF9F9F9,
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
