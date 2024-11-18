import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../bloc/address_bloc/address_bloc.dart';
import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import '../../../widget_small/custom_button.dart';
import '../../home/product/adress/adress_add_screen.dart';
import '../../home/product/adress/adress_screen.dart';

class AddressScreenUser extends StatefulWidget {
  const AddressScreenUser({super.key});

  @override
  State<AddressScreenUser> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreenUser> {
  int _selectedAddress = -1; // Track the selected address

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(
            onTap: () {

            }),
            //     Navigator.push(context,MaterialPageRoute(builder: (context) =>  const AccountSettingsScreen(),)),
            // child: const Icon(
            //   Icons.arrow_back_ios,
            //   color: Styles.light,
            // )),
        title: Text(
          'Địa Chỉ',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Styles.light,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Địa chỉ đã thêm',
                ),
              ],
            ),

            Expanded(
              child: BlocProvider(
                create: (context) => AddressBloc()..add(FetchAddresses()),
                child: BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AddressLoaded) {
                      return ListView.builder(
                        itemCount: state.addresses.length,
                        itemBuilder: (context, index) {
                          final address = state.addresses[index];
                          return GestureDetector(
                            onLongPress: () {
                              // _showDeleteConfirmationDialog(context, address.id);
                            },
                            child: AddressItem(
                              label: address.name,
                              address: address.address,
                              isSelected: _selectedAddress == index,
                              isDefault: address.isDefault == 1,
                              onChanged: () {
                                setState(() {
                                  _selectedAddress = index;
                                });
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is AddressError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('No addresses found.'));
                  },
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: Styles.grey)),
              child: TextButton.icon(
                onPressed: () async {
                  // Navigate to the AddAddressScreen and wait for the result
                  // AddressScreen
                  final result = await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAddressScreen(),
                    ),
                        (route) => false,
                  );

                  if (result == true) {
                    // Refresh addresses by adding FetchAddresses event
                    context.read<AddressBloc>().add(FetchAddresses());
                  }
                },
                icon: const Icon(Icons.add, color: Colors.black87),
                label: Text(
                  'Thêm địa chỉ mới',
                  style: context.theme.textTheme.titleLarge?.copyWith(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Save Button
            InkWell(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: const CusButton(text: "Lưu thay đổi", color: Styles.blue)),
          ],
        ),
      ),
    );
  }
}

class AddAddressScreenUser extends StatefulWidget {
  const AddAddressScreenUser({super.key});

  @override
  State<AddAddressScreenUser> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreenUser> {
  bool isDefault = false;
  String addressAlias = 'Nhà riêng';
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
              onTap: () => Navigator.pop(context),
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
                      onTap: () async {
                        // Lấy thông tin từ các controller
                        final address = {
                          "alias": addressAlias,
                          "country": countryController.text,
                          "province": provinceController.text,
                          "ward": wardController.text,
                          "detailedAddress": detailedAddressController.text,
                          "isDefault": isDefault,
                        };

                        // Lưu vào SharedPreferences
                        final prefs = await SharedPreferences.getInstance();
                        List<String> addresses =
                            prefs.getStringList('addresses') ?? [];
                        addresses.add(address.toString());
                        await prefs.setStringList('addresses', addresses);

                        // Hiển thị thông báo thành công
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Lưu địa chỉ thành công!")),
                        );

                        // Reset form
                        setState(() {
                          addressAlias = 'Nhà riêng';
                          countryController.clear();
                          provinceController.clear();
                          wardController.clear();
                          detailedAddressController.clear();
                          isDefault = false;
                        });
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
