import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc_seller/seller_product_details_bloc_bloc/seller_product_details_bloc_bloc.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mall_product_seller/user_mail_shop_product_Sales.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';

class ProductActiveDetailsScreen extends StatefulWidget {
  final String? productId;
  const ProductActiveDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductActiveDetailsScreen> createState() =>
      _ProductActiveScreenState();
}

class _ProductActiveScreenState extends State<ProductActiveDetailsScreen> {
  final TextEditingController brandController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController occasionController = TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController manufacturerAddressController =
      TextEditingController();
  String selectedGender = 'Nam';

  @override
  void dispose() {
    brandController.dispose();
    originController.dispose();
    materialController.dispose();
    occasionController.dispose();
    manufacturerController.dispose();
    manufacturerAddressController.dispose();
    super.dispose();
  }

  String mapGenderToApiValue(String vietnameseGender) {
    switch (vietnameseGender) {
      case 'Nam':
        return 'male';
      case 'Nữ':
        return 'female';
      case 'Tất cả':
        return 'other';
      default:
        return 'other';
    }
  }

  bool validateFields() {
    if (brandController.text.isEmpty) {
      _showMessage('Lỗi', 'Thương hiệu không được để trống');
      return false;
    }
    if (originController.text.isEmpty) {
      _showMessage('Lỗi', 'Nguồn gốc không được để trống');
      return false;
    }
    if (materialController.text.isEmpty) {
      _showMessage('Lỗi', 'Vật liệu không được để trống');
      return false;
    }
    if (occasionController.text.isEmpty) {
      _showMessage('Lỗi', 'Dịp không được để trống');
      return false;
    }
    if (manufacturerController.text.isEmpty) {
      _showMessage('Lỗi', 'Tên nhà sản xuất không được để trống');
      return false;
    }
    if (manufacturerAddressController.text.isEmpty) {
      _showMessage('Lỗi', 'Địa chỉ nhà sản xuất không được để trống');
      return false;
    }
    return true;
  }

  void saveData(BuildContext context) {
    if (!validateFields()) return;

    final productDetails = Productdetails(
      productId: widget.productId ?? '',
      brand: brandController.text,
      gender: mapGenderToApiValue(selectedGender),
      origin: originController.text,
      material: materialController.text,
      occasion: occasionController.text,
      manufacturer: manufacturerController.text,
      manufacturerAddress: manufacturerAddressController.text,
    );

    context.read<ProductDetailsBloc>().add(FetchProductDetail(productDetails));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: cusAppBarCircle(context, title: "Thông tin sản phẩm"),
          ),
          Expanded(
            child: BlocConsumer<ProductDetailsBloc, ProductState>(
              listener: (context, state) async {
                if (state is ProductSuccess) {
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

                  // Đợi 2 giây rồi chuyển sang màn hình mới
                  await Future.delayed(const Duration(seconds: 2));

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductActiveSalesScreen(
                        productId: widget.productId,
                      ),
                    ),
                  );
                } else if (state is ProductError) {
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
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        CustomTextFieldNoIcon(
                          controller: brandController,
                          label: "Thương Hiệu",
                          hintText: "Điền thông tin tại đây",
                        ),
                        _buildDropdownSection(
                          "Giới tính",
                          selectedGender,
                          ['Nam', 'Nữ', 'Tất cả'],
                          (value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                        CustomTextFieldNoIcon(
                          controller: originController,
                          label: "Nguồn gốc",
                          hintText: "Điền thông tin tại đây",
                        ),
                        CustomTextFieldNoIcon(
                          controller: materialController,
                          label: "Vật liệu",
                          hintText: "Điền thông tin tại đây",
                        ),
                        CustomTextFieldNoIcon(
                          controller: occasionController,
                          label: "Dịp",
                          hintText: "Điền thông tin tại đây",
                        ),
                        CustomTextFieldNoIcon(
                          controller: manufacturerController,
                          label: "Tên Nhà Sản Xuất",
                          hintText: "Điền thông tin tại đây",
                        ),
                        CustomTextFieldNoIcon(
                          controller: manufacturerAddressController,
                          label: "Địa chỉ Nhà Sản Xuất",
                          hintText: "Điền thông tin tại đây",
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF218FF2),
                                      Color(0xFF13538C),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ElevatedButton(
                                  onPressed: () => saveData(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      'Lưu thay đổi',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
