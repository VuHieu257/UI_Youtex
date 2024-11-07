import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../bloc_seller/seller_register_bloc/seller_register_bloc.dart';
import '../../../../bloc_seller/seller_register_bloc/seller_register_event.dart';
import '../../../../core/colors/color.dart';
import '../../../../services/restful_api_provider.dart';
import '../../../widget_small/appbar/custome_appbar_circle.dart';
import '../../../widget_small/text_form_field.dart';
import '../user_mail/profile_mall.dart';

class RegisterMallDetailScreen extends StatefulWidget {
  const RegisterMallDetailScreen({super.key});

  @override
  State<RegisterMallDetailScreen> createState() =>
      _RegisterMallDetailScreenState();
}

class _RegisterMallDetailScreenState extends State<RegisterMallDetailScreen> {
  bool isCheck = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  XFile? _selectedImage;
  bool isLoading = true;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  late SellerRegisterBloc _sellerRegisterBloc;

  @override
  void initState() {
    super.initState();
    _sellerRegisterBloc = SellerRegisterBloc(
      restfulApiProvider: RestfulApiProviderImpl(),
    );
    _loadInitialData();
  }

  void _loadInitialData() {
    _sellerRegisterBloc.add(const LoadStoreInfo());
    _sellerRegisterBloc.stream.listen((state) {
      if (state is SellerRegisterLoaded) {
        // Nếu có dữ liệu cửa hàng, điều hướng ngay lập tức
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserMailDetailsShop(),
          ),
        );
      } else if (state is SellerRegisterFailure) {
        // Nếu có lỗi (không tìm thấy cửa hàng), hiển thị form đăng ký
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _sellerRegisterBloc,
      child: BlocConsumer<SellerRegisterBloc, SellerRegisterState>(
        listener: (context, state) {
          if (state is SellerRegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Đăng ký thành công!")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const UserMailDetailsShop(),
              ),
            );
          } else if (state is SellerRegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Lỗi: ${state.error}")),
            );
            setState(() {
              isLoading = false;
            });
          }
        },
        builder: (context, state) {
          if (isLoading && state is! SellerRegisterFailure) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            body: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: cusAppBarCircle(context, title: "Đăng ký Mall"),
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
                            controller: _nameController,
                            label: "Tên cửa hàng",
                            hintText: "Điển thông tin tại đây",
                          ),
                          CustomTextFieldNoIcon(
                            controller: _phoneController,
                            label: "Số điện thoại cửa hàng",
                            hintText: "Điển thông tin tại đây",
                          ),
                          CustomTextFieldNoIcon(
                            controller: _emailController,
                            label: "Email cửa hàng",
                            hintText: "Điển thông tin tại đây",
                          ),
                          Text(
                            'Ảnh chụp cùng giấy tờ',
                            style: context.theme.textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                                color: Styles.colorF9F9F9,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 4),
                                      blurRadius: 4)
                                ]),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: Styles.colorF9F9F9,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        border: Border.all(width: 1)),
                                    child: const Text(
                                      'Choose File',
                                      style:
                                          TextStyle(color: Styles.nearPrimary),
                                    ),
                                  ),
                                ),
                                _selectedImage != null
                                    ? Image.file(
                                        File(_selectedImage!.path),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : const Text('No file chosen'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.greenAccent,
                                value: isCheck,
                                onChanged: (value) {
                                  setState(() {
                                    isCheck = value!;
                                  });
                                },
                              ),
                              Text.rich(TextSpan(
                                  style: context.theme.textTheme.headlineSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: const [
                                    TextSpan(text: "Tôi đồng ý với các"),
                                    TextSpan(
                                      text: " điều khoản và điều kiện",
                                      style: TextStyle(color: Styles.blue),
                                    ),
                                  ])),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isCheck = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15),
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
                                  child: TextButton(
                                    onPressed: () {
                                      if (isCheck) {
                                        if (_nameController.text.isEmpty ||
                                            _phoneController.text.isEmpty ||
                                            _emailController.text.isEmpty) {
                                          // Hiển thị lỗi nếu các trường bắt buộc chưa được nhập
                                          print(_nameController);
                                          print(_phoneController);
                                          print(_emailController);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Vui lòng điền đầy đủ tên cửa hàng, số điện thoại và email')),
                                          );
                                          return;
                                        }
                                        context.read<SellerRegisterBloc>().add(
                                              SellerRegisterButtonPressed(
                                                name: _nameController.text,
                                                imagePath:
                                                    _selectedImage?.path ?? '',
                                                phone: _phoneController.text,
                                                email: _emailController.text,
                                              ),
                                            );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Vui lòng chấp nhận điều khoản")),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "Đăng ký mall",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (state is SellerRegisterLoading)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

  const CustomTextFieldNoIcon({
    super.key,
    required this.hintText,
    required this.label,
    this.line,
    required this.controller,
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
              controller: controller, // Bind the controller here
              maxLines: line ?? null,
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
