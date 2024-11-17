import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../core/colors/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final Color bg;
  final Color colorText;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.bg,
    required this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Styles.defaultPadding),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            filled: true,
            // Cho phép tô màu nền
            fillColor: bg,
            // border: const OutlineInputBorder(
            //   borderRadius: BorderRadius.all(
            //       Radius.circular(15)
            //   ),
            // ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)), // Bo góc
              borderSide: BorderSide.none, // Loại bỏ viền
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: colorText,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
            prefixIcon: prefixIcon),
      ),
    );
  }
}

class CustomTextFieldNoIcon extends StatelessWidget {
  final String label;
  final String hintText;
  final int? line;
  final bool? readOnly;
  final TextEditingController? controller;

  const CustomTextFieldNoIcon(
      {super.key,
      required this.hintText,
      required this.label,
      this.line,
      this.controller,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12.0), // Khoảng cách giữa các trường
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Styles.colorF9F9F9,
        ),
        child: TextField(
          readOnly: readOnly ?? false,
          controller: controller,
          maxLines: line,
          decoration: InputDecoration(
            labelText: label, // Tiêu đề nằm bên trong TextField
            labelStyle: const TextStyle(
              color: Colors.black, // Màu chữ tiêu đề
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            hintStyle: const TextStyle(
                color: Color(0xFFB5B2B2),
                fontSize: 14,
                fontWeight: FontWeight.bold),
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: Styles.colorF9F9F9,
          ),
        ),
      ),
    );
  }
}
