import 'package:flutter/material.dart';
import 'package:youtext_app/core/size/size.dart';
import 'package:youtext_app/core/themes/theme_extensions.dart';
import '../../core/colors/color.dart';

class CusButton extends StatelessWidget {
  final String text;
  final Color color;
  const CusButton({super.key,required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(Styles.defaultPadding),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color
      ),
      child: Text(text, style: context.theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,color: Styles.light)),
    );
  }
}
