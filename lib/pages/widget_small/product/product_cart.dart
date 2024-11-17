import 'package:flutter/material.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/util/constants.dart';

import '../../../core/colors/color.dart';

class CartItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final String price;
  final int amount;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;

  const CartItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.price,
    required this.isSelected,
    required this.amount,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1, color: Styles.greyLight))),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: onSelected,
            ),
            Container(
              width: context.height * 0.1,
              height: context.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          "${NetworkConstants.urlImage}$imageUrl"),fit: BoxFit.fill)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.width * 0.55,
                    child: Text(
                      name,
                      style: context.theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(height: context.height * 0.01),
                  Row(
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Loại: $type',
                        style: context.theme.textTheme.titleMedium?.copyWith(),
                      ),
                      const Spacer(),
                      Text(
                        '$price đ',
                        style: context.theme.textTheme.titleMedium?.copyWith(),
                      ),
                    ],
                  ),
                  SizedBox(height: context.height * 0.005),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {},
                            ),
                            Text(
                              "$amount",
                              style: context.theme.textTheme.titleMedium
                                  ?.copyWith(),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.delete_outline,
                            color: Styles.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
