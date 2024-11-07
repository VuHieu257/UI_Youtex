import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/bloc_seller/seller_register_identification_bloc/seller_register_identification_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';

import '../../../../core/colors/color.dart';
import '../../../widget_small/appbar/custome_appbar_circle.dart';

class RegisterMallIdentificationScreen extends StatefulWidget {
  const RegisterMallIdentificationScreen({super.key});

  @override
  _RegisterMallIdentificationScreenState createState() =>
      _RegisterMallIdentificationScreenState();
}

class _RegisterMallIdentificationScreenState
    extends State<RegisterMallIdentificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _settingsController = TextEditingController();
  XFile? _image;
  XFile? _selfie;

  Future<void> _pickImage(bool isSelfie) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (isSelfie) {
          _selfie = image;
        } else {
          _image = image;
        }
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
            child: cusAppBarCircle(context, title: "Thông tin xác thực"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      CustomTextFieldNoIcon(
                        controller: _unitController,
                        label: "Type",
                        hintText: "id_card",
                        line: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Loại giấy tờ là bắt buộc';
                          }
                          return null;
                        },
                      ),
                      CustomTextFieldNoIcon(
                        controller: _descriptionController,
                        label: "number",
                        hintText: "Điền thông tin tại đây",
                        line: 7,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Số giấy tờ là bắt buộc';
                          }
                          return null;
                        },
                      ),
                      CustomTextFieldNoIcon(
                        controller: _settingsController,
                        label: "name",
                        hintText: "Điền thông tin tại đây",
                        line: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tên trên giấy tờ là bắt buộc';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => _pickImage(false),
                        child: _image == null
                            ? Container(
                          height: 100,
                          color: Colors.grey[200],
                          child: const Center(child: Text("Chọn ảnh")),
                        )
                            : Image.file(
                          File(_image!.path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => _pickImage(true),
                        child: _selfie == null
                            ? Container(
                          height: 100,
                          color: Colors.grey[200],
                          child: const Center(child: Text("Chọn ảnh Selfie")),
                        )
                            : Image.file(
                          File(_selfie!.path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
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
                                    Color(0xFF218FF2), // Light blue
                                    Color(0xFF13538C), // Dark blue
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() &&
                                      _image != null &&
                                      _selfie != null) {
                                    final identification =
                                    SellerIdentificationModel(
                                      type: _unitController.text,
                                      number: _descriptionController.text,
                                      name: _settingsController.text,
                                      image: _image!.path,
                                      selfie: _selfie!.path,
                                    );

                                    // Call the BLoC to post data
                                    context
                                        .read<
                                        SellerRegisterIdentificationBlocBloc>()
                                        .add(
                                      SellerRegisterIdentificationPostEvent(
                                          identification: identification),
                                    );

                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const CardAddedSuccessDialog();
                                      },
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Vui lòng điền đầy đủ thông tin và chọn ảnh"),
                                      ),
                                    );
                                  }
                                },
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
              ),
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
  final int? line;

  const CustomTextFieldNoIcon({
    super.key,
    required this.hintText,
    required this.label,
    this.line,
    required TextEditingController controller,
    required String? Function(dynamic value) validator,
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
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ]),
            child: TextField(
              maxLines: line,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                hintText: hintText,
                filled: true,
                fillColor: Styles.colorF9F9F9,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
