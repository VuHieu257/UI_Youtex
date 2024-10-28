import 'package:flutter/material.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/member_Vip/member_packagePayment.dart';

import '../../../../core/colors/color.dart';
import '../../../widget_small/custom_button.dart';
import '../../home/add_success/add_success.dart';

class CardInputApp extends StatelessWidget {
  const CardInputApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Styles.light,
            )),
        title: Text(
          'Thêm thẻ mới',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Styles.light,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thêm thẻ ghi nợ hoặc thẻ tín dụng',
              style: context.theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 20.0),
            // Card Number Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Số thẻ',
                hintText: '**** **** **** 2512',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
              ),
            ),
            const SizedBox(height: 20.0),
            // Expiry Date and Security Code
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      hintText: '07/23',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Security Code',
                      hintText: '345',
                      suffixIcon: const Icon(Icons.help_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            // Save Button
            const Spacer(),
            InkWell(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CardAddedSuccessDialog();
                  },
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MembershipPaymentScreen(), // Trang bạn muốn chuyển tới
                  ),
                );
              },
              child: const CusButton(text: "Save", color: Styles.blue),
            ),
          ],
        ),
      ),
    );
  }
}
