import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/voucher/Voucher_seller_add.dart';

import '../../../../core/colors/color.dart';
import '../../../widget_small/appbar/custome_appbar_circle.dart';
import '../../../widget_small/text_form_field.dart';
import '../user_mail/profile_mall.dart';

class RegisterMallinforExhibitiScreen extends StatelessWidget {
  const RegisterMallinforExhibitiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: cusAppBarCircle(context, title: "Giấy Tờ"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Loại giấy tờ (CCCD/CMND/Hộ Chiếu)",
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
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Styles.colorF9F9F9,
                        ),
                        dropdownColor: Styles.colorF9F9F9,
                        value: 'CCCD', // Giá trị mặc định, nếu cần
                        isExpanded: true,
                        items: ['CCCD', 'CMND', 'Hộ Chiếu']
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                        onChanged: (value) {
                          // Xử lý khi chọn loại giấy tờ
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                      ),
                    ),
                    const CustomTextFieldNoIcon(
                        label: "Số giấy tờ",
                        hintText: "Điền thông tin tại đây"),
                    const SizedBox(height: 20),
                    Text(
                      'Ảnh giấy tờ',
                      style: context.theme.textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                              Container(
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
                                  style: TextStyle(color: Styles.nearPrimary),
                                ),
                              ),
                              const Text('Ảnh mặt trước.png'),
                            ],
                          ),
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
                              Container(
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
                                  style: TextStyle(color: Styles.nearPrimary),
                                ),
                              ),
                              const Text('Ảnh mặt sau.png'),
                            ],
                          ),
                        ),
                        // Bổ sung trường ảnh giấy tờ mới
                        Row(
                          children: [
                            Text(
                              'Ảnh chụp cùng giấy tờ',
                              style: context.theme.textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
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
                              Container(
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
                                  style: TextStyle(color: Styles.nearPrimary),
                                ),
                              ),
                              const Text('Ảnh bổ sung.png'),
                            ],
                          ),
                        ),
                      ],
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
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CardAddedSuccessDialog();
                                  },
                                );
                                Navigator.pop(context);
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
        ],
      ),
    );
  }
}
