import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import '../../../../core/colors/color.dart';
import '../../../../main.dart';
import '../../../widget_small/card_option.dart';
import '../../../widget_small/custom_button.dart';
import '../checkout_page/checkout_page.dart';
class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _selectedCardIndex = 0; // Default selected card index

  List<Map<String, String>> savedCards = [
    {'type': 'VISA', 'number': '**** **** **** 2512', 'isDefault': 'true'},
    {'type': 'MasterCard', 'number': '**** **** **** 5421', 'isDefault': 'false'},
    {'type': 'VISA', 'number': '**** **** **** 2512', 'isDefault': 'false'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back_ios,color: Styles.light,)),
        title: Text('Phương thức thanh toán',style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Saved Cards List
            Expanded(
              child: ListView.builder(
                itemCount: savedCards.length,
                itemBuilder: (context, index) {
                  var card = savedCards[index];
                  return CardOption(
                    cardType: card['type']!,
                    cardNumber: card['number']!,
                    isSelected: _selectedCardIndex == index,
                    isDefault: card['isDefault'] == 'true',
                    onTap: () {
                      setState(() {
                        _selectedCardIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            // Add New Card Button
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(borderRadius:BorderRadius.circular(16),border: Border.all( width: 1,color: Styles.grey)),
              child: TextButton.icon(
                onPressed: () {
                  // Handle adding a new card
                },
                icon: const Icon(Icons.add, color: Colors.black87),
                label: Text('Thêm thẻmới',style: context.theme.textTheme.titleMedium?.copyWith( ),),
              ),
            ),
            const SizedBox(height: 20),
            // Save Button
            InkWell(onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const CheckoutPage(),)),child: const CusButton(text:"Lưu",color:Styles.blue)),
          ],
        ),
      ),
    );
  }
}