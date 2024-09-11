
import 'package:flutter/material.dart';

import '../../core/assets.dart';
class CardOption extends StatelessWidget {
  final String cardType;
  final String cardNumber;
  final bool isSelected;
  final bool isDefault;
  final VoidCallback onTap;

  const CardOption({super.key,
    required this.cardType,
    required this.cardNumber,
    required this.isSelected,
    required this.isDefault,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  cardType == 'VISA'
                      ? Asset.iconVisa // Replace with your visa image asset
                      : Asset.iconMastercard , // Replace with your mastercard image asset
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$cardType $cardNumber', style: TextStyle(fontSize: 16)),
                    if (isDefault)
                      Text('Default', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Radio(
              value: isSelected,
              groupValue: true,
              onChanged: (value) {
                onTap();
              },
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}