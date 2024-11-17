import 'package:flutter/material.dart';
// Import Dio
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

import '../../../../core/colors/color.dart';
import '../../../widget_small/appbar/custome_appbar_circle.dart';

class RegisterMallinforShopScreen extends StatefulWidget {
  const RegisterMallinforShopScreen({super.key});

  @override
  _RegisterMallinforShopScreenState createState() =>
      _RegisterMallinforShopScreenState();
}

class _RegisterMallinforShopScreenState
    extends State<RegisterMallinforShopScreen> {
  final TextEditingController shippingUnitController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController settingsController = TextEditingController();
  final RestfulApiProviderImpl restfulApiProviderImpl =
      RestfulApiProviderImpl();

  @override
  void dispose() {
    shippingUnitController.dispose();
    descriptionController.dispose();
    settingsController.dispose();
    super.dispose();
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

  // Hàm gửi dữ liệu
  Future<void> saveData() async {
    final token = await TokenManager.getToken();

    String shippingUnit = shippingUnitController.text;
    String description = descriptionController.text;
    Map<String, dynamic> settings = const {'is_cod': 1, 'is_active': 1};
    if (shippingUnit.isNotEmpty &&
        description.isNotEmpty &&
        settings.isNotEmpty) {
      bool success = await restfulApiProviderImpl.sendShippingData(
        token: token!,
        shippingUnit: shippingUnit,
        description: description,
        settings: settings,
      );

      if (success) {
        // Nếu thành công, hiển thị thông báo SnackBar với nội dung thành công
        _showMessage('Thành Công', 'Đã thêm thành công!');

        // Đợi thời gian của SnackBar trước khi đóng màn hình
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else {
        // Nếu có lỗi
        _showMessage('Lỗi', 'Đã xảy ra lỗi khi gửi thông tin.');
      }
    } else {
      // Hiển thị thông báo lỗi nếu có trường nào bỏ trống
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: const Text('Vui lòng điền đầy đủ thông tin.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: cusAppBarCircle(context, title: "Mô tả Shop"),
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
                      controller: shippingUnitController,
                      label: "Đơn vị vận chuyển",
                      hintText: "Điền thông tin tại đây",
                      line: 1,
                    ),
                    CustomTextFieldNoIcon(
                      controller: descriptionController,
                      label: "Mô tả đơn vị vận chuyển",
                      hintText: "Điền thông tin tại đây",
                      line: 7,
                    ),
                    CustomTextFieldNoIcon(
                      controller: settingsController,
                      label: "Thông tin bổ sung",
                      hintText: "Điền thông tin tại đây",
                      line: 1,
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
                              onPressed: saveData, // Gọi hàm lưu dữ liệu
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
        ],
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
              controller: controller,
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
