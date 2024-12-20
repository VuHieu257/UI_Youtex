import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/bloc_seller/seller_product_extra_bloc_bloc/seller_product_extra_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_extra_bloc_bloc/seller_product_extra_bloc_event.dart';
import 'package:ui_youtex/bloc_seller/seller_product_extra_bloc_bloc/seller_product_extra_bloc_state.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_event.dart';
import 'package:ui_youtex/bloc_seller/seller_product_sales_bloc_bloc/seller_product_sales_bloc_state.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mall_product_seller/user_mail_shop_product_Shipping.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';

class ProductActiveExtraScreen extends StatefulWidget {
  final String? productId;
  const ProductActiveExtraScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductActiveExtraScreen> createState() => _ProductActiveScreenState();
}

class _ProductActiveScreenState extends State<ProductActiveExtraScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController preorderController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  // Sửa giá trị mặc định phù hợp với items trong dropdown
  String selectedGender = 'Hàng có sẵn';
  String selectedStatus = 'Hàng mới';

  String? sizeChartPath;

  @override
  void dispose() {
    preorderController.dispose();
    statusController.dispose();
    skuController.dispose();
    super.dispose();
  }

  String mapGenderToApiValue(String vietnameseGender) {
    switch (vietnameseGender) {
      case 'Hàng có sẵn':
        return '1';
      case 'Hàng đặt':
        return '0';
      default:
        return '1';
    }
  }

  String mapStatusToApiValue(String vietnameseStatus) {
    switch (vietnameseStatus) {
      case 'Hàng mới':
        return 'new';
      case 'Hàng cũ':
        return 'old';
      default:
        return 'new';
    }
  }

  String? _validateSku(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mã SKU';
    }
    if (int.tryParse(value) == null) {
      return 'Vui lòng nhập số nguyên hợp lệ';
    }
    return null;
  }

  void _saveData(BuildContext context) {
    // Kiểm tra xem form có hợp lệ không
    if (_formKey.currentState?.validate() ?? false) {
      // Nếu hợp lệ, gọi sự kiện
      final productExtra = UpdateSellerProductExtraEvent(
        productId: widget.productId ?? '',
        isPreOrder: mapGenderToApiValue(selectedGender),
        status: mapStatusToApiValue(selectedStatus),
        sku: skuController.text,
      );
      context.read<SellerProductExtraBloc>().add(productExtra);
    } else {
      // Nếu không hợp lệ, không thực hiện gì
      return;
    }
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
      width: MediaQuery.of(context).size.width,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: cusAppBarCircle(context, title: "Thông tin Extra"),
          ),
          Expanded(
            child:
                BlocConsumer<SellerProductExtraBloc, SellerProductExtraState>(
              listener: (context, state) {
                if (state is SellerProductExtraSuccess) {
                  // Hiển thị thông báo thành công bằng CustomDialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: 'Thành Công',
                        message: state.message,
                      );
                    },
                  );

                  // Sau 1500ms, điều hướng đến màn hình ProductActiveShipingScreen
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductActiveShipingScreen(
                          productId: widget.productId,
                        ),
                      ),
                    );
                  });
                } else if (state is SellerProductExtraError) {
                  // Hiển thị thông báo lỗi nếu có lỗi
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: 'Lỗi',
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
                            "Sẵn hàng",
                            selectedGender,
                            [
                              'Hàng có sẵn',
                              'Hàng đặt',
                            ],
                            (value) {
                              if (value != null) {
                                setState(() {
                                  selectedGender = value;
                                });
                              }
                            },
                          ),
                          _buildDropdownSection(
                            "Tình trạng",
                            selectedStatus,
                            [
                              'Hàng mới',
                              'Hàng cũ',
                            ],
                            (value) {
                              if (value != null) {
                                setState(() {
                                  selectedStatus = value;
                                });
                              }
                            },
                          ),
                          _buildTextField(
                            controller: skuController,
                            label: "Mã SKU",
                            hintText: "Điền thông tin tại đây",
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Vui lòng nhập số lượng';
                              }
                            },
                          ),
                          _buildSubmitButton(
                              state is SellerProductExtraLoading),
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
  final TextInputType keyboardType;
  final String? Function(String?) validator;

  const CustomTextFieldNoIcon({
    Key? key,
    required this.hintText,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.validator,
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
            child: TextFormField(
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
              keyboardType: keyboardType,
              validator: validator, // Ensure SKU validation
            ),
          ),
        ],
      ),
    );
  }
}
