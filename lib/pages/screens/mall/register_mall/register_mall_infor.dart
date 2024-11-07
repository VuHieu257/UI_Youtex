import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc_seller/bloc/bloc_seller_address_bloc.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';

class RegisterMallinforScreen extends StatefulWidget {
  const RegisterMallinforScreen({super.key});

  @override
  State<RegisterMallinforScreen> createState() =>
      _RegisterMallinforScreenState();
}

class _RegisterMallinforScreenState extends State<RegisterMallinforScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _provinceController = TextEditingController();
  final _wardController = TextEditingController();
  final _addressController = TextEditingController();
  final _businessAddressController = TextEditingController();
  bool isDefault = true;
  bool hasExistingAddress = false;

  @override
  void initState() {
    super.initState();
    context.read<SellerAddressBloc>().add(FetchAddressEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _provinceController.dispose();
    _wardController.dispose();
    _addressController.dispose();
    _businessAddressController.dispose();
    super.dispose();
  }

  void _submitAddress() {
    if (hasExistingAddress) return; // Prevent submission if address exists

    context.read<SellerAddressBloc>().add(
      SubmitAddressEvent(
        name: _nameController.text,
        phone: _phoneController.text,
        country: _countryController.text,
        province: _provinceController.text,
        ward: _wardController.text,
        address: _addressController.text,
        longitude: "0",
        latitude: "0",
        isDefault: isDefault,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SellerAddressBloc, SellerAddressState>(
        listener: (context, state) {
          if (state is SellerAddressPostSuccess) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CardAddedSuccessDialog();
              },
            ).then((_) => Navigator.pop(context));
          } else if (state is SellerAddressError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          if (state is SellerAddressLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SellerAddressGetSuccess) {
            // Parse the response and check if addresses exist
            final Map<String, dynamic> response = state.data;
            if (response['addresses'] != null &&
                response['addresses'].isNotEmpty) {
              hasExistingAddress = true;
              final address = response['addresses'][0]; // Get first address

              // Fill the controllers with existing data
              _nameController.text = address['name'] ?? '';
              _phoneController.text = address['phone'] ?? '';
              _countryController.text = address['country'] ?? '';
              _provinceController.text = address['province'] ?? '';
              _wardController.text = address['ward'] ?? '';
              _addressController.text = address['address'] ?? '';
              isDefault = address['is_default'] == 1;
            }
          }

          return Column(
            children: [
              Padding(
                padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child:
                cusAppBarCircle(context, title: "Thông tin doanh nghiệp"),
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
                          label: "Tên Mall",
                          hintText: "Điền thông tin tại đây",
                          controller: _nameController,
                          readOnly: hasExistingAddress,
                        ),
                        CustomTextFieldNoIcon(
                          label: "Phone",
                          hintText: "Điền thông tin tại đây",
                          controller: _phoneController,
                          readOnly: hasExistingAddress,
                        ),
                        CustomTextFieldNoIcon(
                          label: "Country",
                          hintText: "Điền thông tin tại đây",
                          controller: _countryController,
                          readOnly: hasExistingAddress,
                        ),
                        CustomTextFieldNoIcon(
                          label: "Province",
                          hintText: "Điền thông tin tại đây",
                          controller: _provinceController,
                          readOnly: hasExistingAddress,
                        ),
                        CustomTextFieldNoIcon(
                          label: "Ward",
                          hintText: "Điền thông tin tại đây",
                          controller: _wardController,
                          readOnly: hasExistingAddress,
                        ),
                        CustomTextFieldNoIcon(
                          label: "Address",
                          hintText: "Điền thông tin tại đây",
                          controller: _addressController,
                          readOnly: hasExistingAddress,
                        ),
                        if (!hasExistingAddress) // Only show checkbox if no existing address
                          Row(
                            children: [
                              Checkbox(
                                value: isDefault,
                                onChanged: (value) {
                                  setState(() {
                                    isDefault = value ?? true;
                                  });
                                },
                              ),
                              Text(
                                "Đặt làm mặc định",
                                style: context.theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        const SizedBox(height: 30),
                        if (!hasExistingAddress) // Only show submit button if no existing address
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
                                    onPressed: _submitAddress,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding:
                                      EdgeInsets.symmetric(vertical: 15),
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomTextFieldNoIcon extends StatelessWidget {
  final String label;
  final String hintText;
  final int? line;
  final TextEditingController controller;
  final bool readOnly;

  const CustomTextFieldNoIcon({
    super.key,
    required this.hintText,
    required this.label,
    this.line,
    required this.controller,
    this.readOnly = false,
  });

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
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: readOnly
                  ? []
                  : const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 4,
                )
              ],
            ),
            child: TextField(
              controller: controller,
              maxLines: line,
              readOnly: readOnly,
              style: TextStyle(
                color: readOnly ? Colors.grey : Colors.black,
              ),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                hintText: hintText,
                filled: true,
                fillColor: readOnly ? Colors.grey[200] : Styles.colorF9F9F9,
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
