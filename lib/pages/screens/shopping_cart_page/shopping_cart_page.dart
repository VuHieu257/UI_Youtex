import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc/cart_bloc/cart_bloc.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/util/constants.dart';

import '../../../core/assets.dart';
import '../../../core/colors/color.dart';
import '../../widget_small/custom_button.dart';
import '../../widget_small/product/product_cart.dart';
import 'checkout_page/checkout_page.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  // State to track which items are selected
  final List<bool> _isSelected = [false, false, false];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          'Giỏ hàng',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              Asset.iconMessage,
              width: context.width * 0.06,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetCartSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: state.carts.map((cart) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.grey.shade100,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                "${NetworkConstants.urlImage}${cart.store.image}",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              cart.store.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: cart.cartItems.map((cartItem) {
                          return CartItem(
                            imageUrl: cartItem.images[0],
                            name: cartItem.name,
                            type:"${cartItem.options.sizes[0].name},${cartItem.options.colors[0].name}",
                            price: int.tryParse(cartItem.discountPrice) ?? 0,
                            isSelected: _isSelected[0],
                            amount: cartItem.quantity,
                            onSelected: (bool? value) {
                              setState(() {
                                _isSelected[0] = value ?? false;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          }
          if (state is CartError) {
            return Center(
              child: Text("Đã xảy ra lỗi: ${state.message}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
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
          SizedBox(height: context.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Phí vận chuyển',
                  style: context.theme.textTheme.headlineSmall),
              Text('0đ',
                  style: context.theme.textTheme.headlineSmall?.copyWith(
                      color: Styles.blue, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: context.height * 0.01),
          const Divider(),
          SizedBox(height: context.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tổng cộng',
                  style: context.theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text('123,000đ',
                  style: context.theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: context.height * 0.02),
          InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutPage(),
                  )),
              child: const CusButton(text: "Mua hàng", color: Styles.blue)),
        ],
      ),
    );
  }
}
