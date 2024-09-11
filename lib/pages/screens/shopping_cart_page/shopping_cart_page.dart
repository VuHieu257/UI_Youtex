import 'package:flutter/material.dart';
import 'package:youtext_app/core/size/size.dart';
import 'package:youtext_app/core/themes/theme_extensions.dart';
import 'package:youtext_app/pages/screens/shopping_cart_page/checkout_page/checkout_page.dart';

import '../../../core/assets.dart';
import '../../../core/colors/color.dart';
import '../../widget_small/custom_button.dart';
import '../../widget_small/product/product_cart.dart';
class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  // State to track which items are selected
  final List<bool> _isSelected = [false, false, false];

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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CartItem(
                  imageUrl: Asset.bgImageProduct,
                  name: 'Vải Cotton May Áo Phông',
                  type: 'Độ Dó, 150x50cm',
                  price: 123000,
                  isSelected: _isSelected[0],
                  onSelected: (bool? value) {
                    setState(() {
                      _isSelected[0] = value ?? false;
                    });
                  },
                ),
                CartItem(
                  imageUrl: Asset.bgImageProduct,
                  name: 'Máy May Một Kim',
                  type: 'Mỏng',
                  price: 123000,
                  isSelected: _isSelected[1],
                  onSelected: (bool? value) {
                    setState(() {
                      _isSelected[1] = value ?? false;
                    });
                  },
                ),
                CartItem(
                  imageUrl:  Asset.bgImageProduct,
                  name: 'Máy May Gia Đình',
                  type: 'Mỏng',
                  price: 123000,
                  isSelected: _isSelected[2],
                  onSelected: (bool? value) {
                    setState(() {
                      _isSelected[2] = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ),
          const SummarySection(),
        ],
      ),
    );
  }
}


class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tạm tính', style: context.theme.textTheme.headlineSmall),
              Text('123,000đ', style: context.theme.textTheme.headlineSmall),
            ],
          ),
          SizedBox(height: context.height*0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Phí vận chuyển', style: context.theme.textTheme.headlineSmall),
              Text('0đ',style: context.theme.textTheme.headlineSmall?.copyWith(color: Styles.blue,fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: context.height*0.01),
          const Divider(),
          SizedBox(height: context.height*0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tổng cộng', style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold
              )),
              Text('123,000đ', style: context.theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold
              )),
            ],
          ),
          SizedBox(height: context.height*0.02),
          InkWell(onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const CheckoutPage(),)),child: const CusButton(text:"Mua hàng",color:Styles.blue)),
        ],
      ),
    );
  }
}