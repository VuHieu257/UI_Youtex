import 'package:flutter/material.dart';
import 'package:youtext_app/core/themes/theme_extensions.dart';

import '../../core/colors/color.dart';
class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const OrderSummaryRow({super.key, required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.theme.textTheme.headlineSmall?.copyWith(fontWeight: isBold ? FontWeight.bold : FontWeight.normal,color:isBold ?Styles.dark: Styles.grey),
            // style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: context.theme.textTheme.headlineSmall?.copyWith(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            // style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
