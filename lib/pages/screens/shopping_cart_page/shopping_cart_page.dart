import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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

  var totalPrice = 0;

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
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetCartSuccess) {
              double totalAmount = 0;
              totalPrice = state.carts.total;
              return SingleChildScrollView(
                child: Column(
                  children: state.carts.stores.map((cart) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.grey.shade100,
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  "${NetworkConstants.urlImage}${cart.image}",
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                cart.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: cart.products.map((product) {
                            return CartItem(
                              imageUrl: product.image,
                              name: product.name,
                              type: "${product.size}, ${product.color}",
                              price:NumberFormat("#,###").format(int.tryParse(product.discountPrice.split('.').first)) ,
                              isSelected: _isSelected[0],
                              amount: product.quantity,
                              onSelected: (bool? value) {
                                setState(() {
                                  _isSelected[0] = value ?? false;
                                });
                              },
                              onTap: () {
                               BlocProvider.of<CartBloc>(context)
                                    .add(DeleteCartEvent(id: "${product.id}"));
                               BlocProvider.of<CartBloc>(context).add(FetchCartEvent());

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
              return  const Center(
                child: Text("Bạn không có sản phẩm trong giỏ hàng"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            var totalPrice = 0;
            var carts = 0;
            if (state is GetCartSuccess) {
              totalPrice = state.carts.total;
              carts = state.carts.stores.length;
            }
            return SizedBox(
              height: 250,
              child: SummarySection(
                price: NumberFormat("#,###").format(totalPrice),
                checkout: carts,
              ),
            );
          },
        ));
  }
}

class SummarySection extends StatelessWidget {
  final String price;
  final int checkout;

  const SummarySection(
      {super.key, required this.price, required this.checkout});

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
              Text(price, style: context.theme.textTheme.headlineSmall),
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
              Text(price,
                  style: context.theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: context.height * 0.02),
          InkWell(
              onTap: () {
                if (checkout > 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutPage(),
                      ));
                }
              },
              child: const CusButton(text: "Mua hàng", color: Styles.blue)),
        ],
      ),
    );
  }
}
