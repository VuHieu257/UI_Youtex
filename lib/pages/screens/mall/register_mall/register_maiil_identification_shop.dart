import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/bloc_seller/seller_register_identification_bloc/seller_register_identification_bloc_bloc.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';

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

  Future<void> _pickImage({required bool isSelfie}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? selectedImage =
          await picker.pickImage(source: ImageSource.gallery);

      if (selectedImage != null) {
        setState(() {
          if (isSelfie) {
            _selfie = selectedImage;
          } else {
            _image = selectedImage;
          }
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_image == null || _selfie == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Vui lòng chọn đủ ảnh giấy tờ và ảnh chụp selfie."),
          ),
        );
        return;
      }

      final identification = SellerIdentificationModel(
        type: _unitController.text,
        number: _descriptionController.text,
        name: _settingsController.text,
        image: _image!.path,
        selfie: _selfie!.path,
      );

      context.read<SellerRegisterIdentificationBlocBloc>().add(
          SellerRegisterIdentificationPostEvent(
              identification: identification));

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomDialog(
            title: 'Thành công',
            message: 'Thông tin xác thực đã được gửi thành công.',
          );
        },
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vui lòng điền đầy đủ thông tin."),
        ),
      );
    }
  }

  Widget _buildImagePicker({required String label, required bool isSelfie}) {
    final XFile? selectedImage = isSelfie ? _selfie : _image;

    return GestureDetector(
      onTap: () => _pickImage(isSelfie: isSelfie),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: selectedImage == null
            ? Center(
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(selectedImage.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
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
            child: cusAppBarCircle(context, title: "Thông tin xác thực"),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    CustomTextFieldNoIcon(
                      controller: _unitController,
                      label: "Loại thẻ",
                      hintText: "id_card",
                      line: 1,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Loại thẻ là bắt buộc'
                          : null,
                    ),
                    CustomTextFieldNoIcon(
                      controller: _descriptionController,
                      label: "Số thẻ",
                      hintText: "Điền thông tin tại đây",
                      line: 1,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Số giấy tờ là bắt buộc'
                          : null,
                    ),
                    CustomTextFieldNoIcon(
                      controller: _settingsController,
                      label: "Tên chủ sở hữu",
                      hintText: "Điền thông tin tại đây",
                      line: 1,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Tên trên giấy tờ là bắt buộc'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    _buildImagePicker(
                      label: "Chọn ảnh giấy tờ",
                      isSelfie: false,
                    ),
                    const SizedBox(height: 20),
                    _buildImagePicker(
                      label: "Chọn ảnh chụp cùng giấy tờ",
                      isSelfie: true,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                        child: const Text(
                          'Lưu thay đổi',
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
