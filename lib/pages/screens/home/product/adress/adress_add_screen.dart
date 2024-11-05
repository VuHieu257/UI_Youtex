import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/model/address.dart';

import '../../../../../bloc/address_bloc/address_bloc.dart';
import '../../../../../core/assets.dart';
import '../../../../../core/colors/color.dart';
import '../../../../widget_small/custom_button.dart';
import '../../../shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'adress_screen.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isDefault = false;
  String addressAlias = 'Nhà riêng'; // Giá trị mặc định cho dropdown
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController detailedAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.blue,
          centerTitle: true,
          leading: InkWell(
              onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddressScreen(),
                    ),
                    (route) => false,
                  ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Styles.light,
              )),
          title: Text(
            'Thêm Địa Chỉ',
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Styles.light,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Image.asset(
                  Asset.bgMap,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Biệt danh",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: addressAlias,
                      items: const [
                        DropdownMenuItem(
                            value: "Nhà riêng", child: Text("Nhà riêng")),
                        DropdownMenuItem(
                            value: "Công ty", child: Text("Công ty")),
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
                    const Text("Địa chỉ chi tiết",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    // TextField(
                    //   controller: addressController,
                    //   decoration: const InputDecoration(
                    //     hintText: "Vinhomes Grand Park, s103, Nguyễn Xiển",
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    // const SizedBox(height: 16),

                    // Nhập quốc gia
                    const Text("Quốc gia",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: countryController,
                      decoration: const InputDecoration(
                        hintText: "Việt Nam",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nhập tỉnh
                    const Text("Tỉnh/Thành phố",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: provinceController,
                      decoration: const InputDecoration(
                        hintText: "Nhập tỉnh",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nhập phường
                    const Text("Phường/Xã",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: wardController,
                      decoration: const InputDecoration(
                        hintText: "Nhập phường",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nhập địa chỉ
                    const Text("Địa chỉ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: detailedAddressController,
                      decoration: const InputDecoration(
                        hintText: "Số 123, Đường ABC",
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
                      onTap: () {
                        context.read<AddressBloc>().add(AddAddress(Address(
                            id: 2,
                            name: addressAlias,
                            phone: "0812507355",
                            country: countryController.text,
                            province: provinceController.text,
                            ward: wardController.text,
                            address: detailedAddressController.text,
                            isDefault: isDefault == true ? 1 : 0)));
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddressScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: CusButton(text: "Thêm", color: Styles.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
