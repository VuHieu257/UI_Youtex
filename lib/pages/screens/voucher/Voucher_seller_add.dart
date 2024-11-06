import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/add_success/add_success.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/profile_mall.dart';
import 'package:ui_youtex/pages/widget_small/appbar/custome_appbar_circle.dart';
import 'package:ui_youtex/pages/widget_small/text_form_field.dart';

import '../../../../core/colors/color.dart';

class VoucheraddScreen extends StatefulWidget {
  const VoucheraddScreen({super.key});

  @override
  State<VoucheraddScreen> createState() => _VoucheraddScreenState();
}

class _VoucheraddScreenState extends State<VoucheraddScreen> {
  String discountType = 'fixed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: cusAppBarCircle(context, title: "Thêm mã giảm giá"),
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
                        label: "Tên Mã giảm giá",
                        hintText: "Điển thông tin tại đây"),
                    const CustomTextFieldNoIcon(
                        label: "Mô tả mã giảm giá",
                        hintText: "Điển thông tin tại đây"),
                    const CustomTextFieldNoIcon(
                        label: "Giá trị giảm",
                        hintText: "Điển thông tin tại đây"),
                    RadioListTile<String>(
                      title: const Text(
                        "Cố định: Giảm một số tiền cụ thể (ví dụ: 50,000 VND)",
                        style: TextStyle(fontSize: 15),
                      ),
                      value: 'fixed',
                      groupValue: discountType,
                      activeColor: Colors.blue[800],
                      onChanged: (value) {
                        setState(() {
                          discountType = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text(
                        "Phần trăm: Giảm theo phần trăm trên giá trị đơn hàng (ví dụ: 20%)",
                        style: TextStyle(fontSize: 15),
                      ),
                      value: 'percentage',
                      groupValue: discountType,
                      activeColor: Colors.blue[800],
                      onChanged: (value) {
                        setState(() {
                          discountType = value!;
                        });
                      },
                    ),
                    Text(
                      'Ngày bắt đầu',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: const Text('dd/mm/yy'),
                              ),
                              const Icon(Icons.calendar_month)
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Ngày kết thúc',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                child: const Text('dd/mm/yy'),
                              ),
                              const Icon(Icons.calendar_month)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const CustomTextFieldNoIcon(
                        label: "Số lần sử dụng tối đa",
                        hintText: "Điển thông tin tại đây"),
                    const SizedBox(height: 20),
                    const CustomTextFieldNoIcon(
                        label: "Điều kiện áp dụng",
                        hintText: "Điển thông tin tại đây"),
                    const SizedBox(height: 20),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(
                                      255, 245, 21, 21), // Light blue
                                  Color.fromARGB(255, 247, 16, 16), // Dark blue
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Add logic for the "Thêm mã giảm giá" button here
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
                                  'Hủy',
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
                            child: ElevatedButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const CardAddedSuccessDialog();
                                  },
                                );
                                Navigator.pop(context);
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
                                  'Thêm',
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
                    )
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
