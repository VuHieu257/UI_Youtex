import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc/cart_checkout_bloc/bloc/checkout_bloc.dart';
import 'package:ui_youtex/bloc/cart_checkout_bloc/bloc/checkout_event.dart';
import 'package:ui_youtex/bloc/cart_checkout_bloc/bloc/checkout_state.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/model/checkout.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/payment_method_screen/payment_method_screen.dart';
import 'package:ui_youtex/pages/widget_small/custom_button.dart';
import '../../../widget_small/custom_button.dart'
    as custom_widget; // Thêm prefix
import 'package:ui_youtex/pages/widget_small/payment_method_button.dart';

import '../../../../services/restful_api_provider.dart';
import '../../../widget_small/bottom_navigation/bottom_navigation.dart';
import '../../home/add_success/add_success.dart';
import '../../user/add_address_screen/add_address_screen.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedPaymentMethod = 'Card';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CheckoutBloc(RestfulApiProviderImpl())..add(FetchCheckoutEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.blue,
          centerTitle: true,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Styles.light,
            ),
          ),
          title: Text(
            'Giỏ hàng',
            style: context.theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Styles.light,
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
        body: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CheckoutLoaded) {
              final checkoutData = state.checkoutResponse;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...checkoutData.stores
                          .map((store) => StoreSection(store: store)),

                      const SizedBox(height: 20),
                      const Divider(),
                      _buildAddressSection(context),
                      const SizedBox(height: 20),
                      const Divider(),

                      // Payment Method Section
                      Text(
                        'Payment Method',
                        style: context.theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
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

                      const SizedBox(height: 20),
                      if (_selectedPaymentMethod == 'Card')
                        const CardInfoSection(),
                      const SizedBox(height: 20),
                      const Divider(),
                      _buildOrderSummarySection(context, checkoutData),

                      InkWell(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                title: 'Thành Công',
                                message: checkoutData.message,
                              );
                            },
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CustomNavBar()),
                          );
                        },
                        child: const CusButton(
                          text: "Thanh toán",
                          color: Styles.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is CheckoutError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}

Widget _buildAddressSection(BuildContext context) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Địa chỉ giao hàng',
                  style: context.theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddressScreenUser(),
                      ));
                },
                child: Text('Thay đổi',
                    style: context.theme.textTheme.bodyMedium
                        ?.copyWith(color: Styles.blue)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 24, color: Styles.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nhà riêng', style: context.theme.textTheme.bodyLarge),
                    Text(
                      'Vinhomes Grand Park, Nguyễn Xiển, Thủ Đức',
                      style: context.theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildOrderSummarySection(
    BuildContext context, CheckoutResponse checkoutData) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tóm tắt đơn hàng',
            style: context.theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          OrderSummaryRow(
              label: 'Số lượng sản phẩm',
              value: '${checkoutData.quantity} sản phẩm'),
          const SizedBox(height: 8),
          const OrderSummaryRow(label: 'Phí vận chuyển', value: '0đ'),
          const Divider(height: 24),
          OrderSummaryRow(
              label: 'Tổng cộng',
              value: '${checkoutData.total}đ',
              isBold: true),
        ],
      ),
    ),
  );
}

class StoreSection extends StatelessWidget {
  final Store store;

  const StoreSection({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    store.image,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.store, size: 40),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  store.name,
                  style: context.theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            ...store.products.map((product) => ProductItem(product: product)),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.image,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 80,
              height: 80,
              color: Colors.grey[300],
              child: const Icon(Icons.image),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: context.theme.textTheme.titleMedium,
                ),
                if (product.size != null || product.color != null)
                  Text(
                    'Size: ${product.size ?? 'N/A'}, Color: ${product.color ?? 'N/A'}',
                    style: context.theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.discountPrice}đ',
                          style: context.theme.textTheme.titleMedium
                              ?.copyWith(color: Styles.blue),
                        ),
                        Text(
                          '${product.originalPrice}đ',
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'x${product.quantity}',
                      style: context.theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardInfoSection extends StatelessWidget {
  const CardInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.credit_card, size: 32, color: Styles.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('VISA **** **** **** 2512',
                      style: context.theme.textTheme.titleSmall),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 24),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentMethodScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const OrderSummaryRow(
      {super.key,
      required this.label,
      required this.value,
      this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: context.theme.textTheme.headlineSmall?.copyWith(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isBold ? Styles.dark : Styles.grey),
            // style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: context.theme.textTheme.headlineSmall?.copyWith(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
            // style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
