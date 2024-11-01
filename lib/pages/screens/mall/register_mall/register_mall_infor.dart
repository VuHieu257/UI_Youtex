import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/voucher/Voucher_seller_add.dart';

import '../../../../core/colors/color.dart';
import '../../../widget_small/appbar/custome_appbar_circle.dart';
import '../../../widget_small/text_form_field.dart';
import '../user_mail/profile_mall.dart';

class RegisterMallinforScreen extends StatelessWidget {
  const RegisterMallinforScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: cusAppBarCircle(context, title: "Thông tin doanh nghiệp"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomTextFieldNoIcon(
                        label: "Tên Mall", hintText: "Điển thông tin tại đây"),
                    const CustomTextFieldNoIcon(
                        label: "Mã số thuế doanh nghiệp",
                        hintText: "Điển thông tin tại đây"),
                    const CustomTextFieldNoIcon(
                        label: "Địa chỉ đăng ký kinh doanh",
                        hintText: "Điển thông tin tại đây"),
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

class RegisterMallDetailScreen extends StatefulWidget {
  const RegisterMallDetailScreen({super.key});

  @override
  State<RegisterMallDetailScreen> createState() =>
      _RegisterMallDetailScreenState();
}

class _RegisterMallDetailScreenState extends State<RegisterMallDetailScreen> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: cusAppBarCircle(context, title: "Đăng ký Mall"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
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
                          borderRadius: BorderRadius.all(Radius.circular(15)),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(width: 1)),
                            child: const Text(
                              'Choose File',
                              style: TextStyle(color: Styles.nearPrimary),
                            ),
                          ),
                          const Text('No file chose'),
                        ],
                      ),
                    ),
                    Text(
                      "Ngân hàng",
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
                        value: 'Vietcombank', // Giá trị mặc định, nếu cần
                        isExpanded: true,
                        items: ['Vietcombank', 'Vietinbank', 'Sacombank']
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
                        label: "Số Tài khoản",
                        hintText: "Điển thông tin tại đây"),
                    Text(
                      "Thẻ tín dụng hoặc thẻ ghi nợ (nếu có)",
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
                        value: 'Vietcombank', // Giá trị mặc định, nếu cần
                        isExpanded: true,
                        items: ['Vietcombank', 'Vietinbank', 'Sacombank']
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
                      label: "Mô tả shop",
                      hintText: "Điển thông tin tại đây",
                      line: 7,
                    ),
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
                            style:
                                context.theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            children: const [
                              TextSpan(text: "Tôi đồng ý với các"),
                              TextSpan(
                                  text: " điều khoản và điều kiện",
                                  style: TextStyle(color: Styles.blue)),
                            ]))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
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
                            child: IconButton(
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
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
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserMailDetailsShop(),
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Đăng ký mall",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Xem chi tiết quyền lợi",
                        style: context.theme.textTheme.headlineSmall?.copyWith(
                            color: const Color(0xff0D00FF),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
