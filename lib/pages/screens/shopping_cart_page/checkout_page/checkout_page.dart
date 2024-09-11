import 'package:flutter/material.dart';
import 'package:youtext_app/core/size/size.dart';
import 'package:youtext_app/core/themes/theme_extensions.dart';
import 'package:youtext_app/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import '../../../widget_small/custom_button.dart';
import '../../../widget_small/payment.dart';
import '../../../widget_small/payment_method_button.dart';
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPaymentMethod = 'Card'; // Default selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.blue,
        centerTitle: true,
        leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back_ios,color: Styles.light,)),
        title: Text('Giỏ hàng',style: context.theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Styles.light,
        ),),
        actions: [
          IconButton(
            icon:Image.asset(Asset.iconMessage,width: context.width*0.06,),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipping Address Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Địa chỉ giao hàng',
                  style: context.theme.textTheme.headlineSmall,
                ),
                TextButton(
                  onPressed: () {
                  },
                  child: Text('Thay đổi',style: context.theme.textTheme.titleMedium,),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 24),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nhà riêng',style: context.theme.textTheme.titleMedium,),
                    Text(
                      'Vinhomes Grand Park, Nguyễn Xiển, Thủ Đức',
                      style: context.theme.textTheme.titleMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            // Payment Method Section
            Text(
              'Payment Method',
              style: context.theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: PaymentMethodButton(
                    label: 'Card',
                    icon: Icons.credit_card,
                    isSelected: _selectedPaymentMethod == 'Card',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'Card';
                      });
                    },
                  ),
                ),
                Expanded(
                  child: PaymentMethodButton(
                    label: 'Cash',
                    icon: Icons.money,
                    isSelected: _selectedPaymentMethod == 'Cash',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'Cash';
                      });
                    },
                  ),
                ),
                Expanded(
                  child: PaymentMethodButton(
                    label: 'Pay',
                    icon: Icons.phone_iphone,
                    isSelected: _selectedPaymentMethod == 'Pay',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'Pay';
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Card Information (Shown only if Card is selected)
            if (_selectedPaymentMethod == 'Card')
              CardInfoSection(),
            SizedBox(height: 20),
            Divider(),

            // Order Summary Section
            Text(
              'Tóm tắt đơn hàng',
              style: context.theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const OrderSummaryRow(label: 'Tạm tính', value: '123,000đ'),
            const OrderSummaryRow(label: 'Phí vận chuyển', value: '0đ'),
            SizedBox(height: context.height*0.01),
            const Divider(),
            SizedBox(height: context.height*0.02),
            const OrderSummaryRow(
              label: 'Tổng cộng',
              value: '123,000đ',
              isBold: true,
            ),
            const Spacer(),
            const CusButton(text:"Thanh toán",color:Styles.blue),
          ],
        ),
      ),
    );
  }
}


// Card Information Section
class CardInfoSection extends StatelessWidget {
  const CardInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1,color: Styles.grey),borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Icon(Icons.credit_card, size: 40, color: Colors.blue),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('VISA **** **** **** 2512', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined,size: 30,),
            onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const PaymentMethodScreen()));
            },
          ),
        ],
      ),
    );
  }
}
