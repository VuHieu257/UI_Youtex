import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_event.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_state.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/model/productSales.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mall_product_seller/user_mail_shop_product_Extra.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';

class ProductActiveSalesScreen extends StatefulWidget {
  final String? productId;
  const ProductActiveSalesScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductActiveSalesScreen> createState() => _ProductActiveScreenState();
}

class _ProductActiveScreenState extends State<ProductActiveSalesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController originalPriceController = TextEditingController();
  final TextEditingController discountPriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController minOrderController = TextEditingController();
  final TextEditingController maxOrderController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  String? sizeChartPath;

  @override
  void dispose() {
    originalPriceController.dispose();
    discountPriceController.dispose();
    quantityController.dispose();
    minOrderController.dispose();
    maxOrderController.dispose();
    super.dispose();
  }

  Future<void> _handleSizeChartPicker() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          sizeChartPath = image.path;
        });
      }
    } catch (e) {
      _showMessage('Lỗi', 'Không thể chọn ảnh. Vui lòng thử lại.');
    }
  }

  Widget _buildSizeChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hình ảnh',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: sizeChartPath != null
              ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Image.file(
                        File(sizeChartPath!),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            sizeChartPath = null;
                          });
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : InkWell(
                  onTap: _handleSizeChartPicker,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 40,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Chọn ảnh cụ thể',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  void _saveData(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      if (sizeChartPath == null) {
        _showMessage('Lỗi', 'Vui lòng chọn ảnh Size Chart');
        return;
      }

      final double? originalPrice =
          double.tryParse(originalPriceController.text);
      final double? discountPrice =
          double.tryParse(discountPriceController.text);
      final int? minOrder = int.tryParse(minOrderController.text);
      final int? maxOrder = int.tryParse(maxOrderController.text);

      // Validate logic for prices and orders
      if (originalPrice != null &&
          discountPrice != null &&
          discountPrice > originalPrice) {
        _showMessage('Lỗi', 'Giá giảm không thể lớn hơn giá gốc');
        return;
      }
      if (minOrder != null && maxOrder != null && minOrder >= maxOrder) {
        _showMessage(
            'Lỗi', 'Số lượng tối thiểu không thể lớn hơn số lượng tối đa');
        return;
      }

      final productSales = ProductSales(
        productId: widget.productId.toString(),
        originalPrice: originalPriceController.text,
        discountPrice: discountPriceController.text,
        quantity: quantityController.text,
        minOrder: minOrderController.text,
        maxOrder: maxOrderController.text,
        sizeChart: sizeChartPath,
      );

      context.read<SellerProductSalesBloc>().add(
            PostSellerProductSalesEvent(
              productSales: productSales,
            ),
          );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomTextFieldNoIcon(
        controller: controller,
        label: label,
        hintText: hintText,
        keyboardType: TextInputType.number,
        validator: validator,
      ),
    );
  }

  Widget _buildSubmitButton(bool isLoading) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Lưu thay đổi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
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

    if (title == 'Thành Công') {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductActiveExtraScreen(
              productId: widget.productId,
            ),
          ),
        );
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
            child: cusAppBarCircle(context, title: "Thông tin bán hàng"),
          ),
          Expanded(
            child: BlocConsumer<SellerProductSalesBloc, ProductSalesState>(
              listener: (context, state) {
                if (state is ProductSalesSuccess) {
                  // Hiển thị dialog thành công
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: 'Thành Công',
                        message: state.message,
                      );
                    },
                  );
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductActiveExtraScreen(
                          productId: widget.productId,
                        ),
                      ),
                    );
                  });
                } else if (state is ProductSalesError) {
                  // Hiển thị thông báo lỗi
                  _showMessage('Thông báo', state.error);
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
                          _buildTextField(
                            controller: originalPriceController,
                            label: "Giá gốc (VND)",
                            hintText: "Điền thông tin tại đây",
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Vui lòng nhập giá gốc';
                              }
                              final double? parsedValue =
                                  double.tryParse(value!);
                              if (parsedValue == null || parsedValue <= 0) {
                                return 'Vui lòng nhập số hợp lệ';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: discountPriceController,
                            label: "Giá giảm (VND)",
                            hintText: "Điền thông tin tại đây",
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Vui lòng nhập giá giảm';
                              }
                              final double? parsedValue =
                                  double.tryParse(value!);
                              if (parsedValue == null || parsedValue < 0) {
                                return 'Vui lòng nhập số hợp lệ';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: quantityController,
                            label: "Số lượng trong kho",
                            hintText: "Điền thông tin tại đây",
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Vui lòng nhập số lượng';
                              }
                              final int? parsedValue = int.tryParse(value!);
                              if (parsedValue == null || parsedValue <= 0) {
                                return 'Vui lòng nhập số nguyên dương';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: minOrderController,
                            label: "Số lượng tối thiểu (Min)",
                            hintText: "Điền thông tin tại đây",
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Vui lòng nhập số lượng tối thiểu';
                              }
                              final int? parsedValue = int.tryParse(value!);
                              if (parsedValue == null || parsedValue <= 0) {
                                return 'Vui lòng nhập số nguyên dương';
                              }
                              return null;
                            },
                          ),
                          _buildTextField(
                            controller: maxOrderController,
                            label: "Số lượng tối đa (Max)",
                            hintText: "Điền thông tin tại đây",
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Vui lòng nhập số lượng tối đa';
                              }
                              final int? parsedValue = int.tryParse(value!);
                              if (parsedValue == null || parsedValue <= 0) {
                                return 'Vui lòng nhập số nguyên dương';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          _buildSizeChartSection(),
                          const SizedBox(height: 20),
                          _buildSubmitButton(state is ProductSalesLoading),
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
