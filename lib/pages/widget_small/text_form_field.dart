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
    required this.bg, required this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:Styles.defaultPadding),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            filled: true, // Cho phép tô màu nền
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
            prefixIcon: prefixIcon
        ),),
    );
  }
}

class CustomTextFieldNoIcon extends StatelessWidget {
  final String label;
  final String hintText;
  final int? line;

  const CustomTextFieldNoIcon({
    super.key,
    required this.hintText, required this.label, this.line,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: context.theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600
          ),),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 4
                  )
                ]
            ),
            child: TextField(
              maxLines: line??null,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xFFB5B2B2)),
                hintText:hintText,
                filled: true,
                fillColor: Styles.colorF9F9F9,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:BorderSide.none
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
