// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_view.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mall_product_seller/user_mail_shop_product_Details.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mall_product_seller/user_mail_shop_productmanager_add.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';

import '../../../../../bloc_seller/seller_register_product_bloc_bloc/seller_register_product_bloc_bloc.dart';

class ProductManagementScreen extends StatelessWidget {
  const ProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellerRegisterProductBloc(
        restfulApiProvider: context.read<RestfulApiProviderImpl>(),
      )..add(SellerRegisterProductGetEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Styles.nearPrimary),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopOverviewScreen(),
                      ),
                    );
                  }),
              title: Column(
                children: [
                  Text(
                    'Quản lý sản phẩm',
                    style: context.theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Styles.nearPrimary,
                    ),
                  ),
                  Divider(
                    indent: context.width * 0.15,
                    endIndent: context.width * 0.15,
                    thickness: 1.5,
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                // Search and Filter Section
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xffF3F3F3),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Tìm sản phẩm',
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return const FilterModal();
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(18),
                              color: const Color(0xffF3F3F3),
                            ),
                            child: const Icon(Icons.filter_alt_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Add Product Button
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductaddScreen(),
                      ),
                    );

                    if (result == true) {
                      if (!context.mounted) return;
                      context
                          .read<SellerRegisterProductBloc>()
                          .add(SellerRegisterProductGetEvent());
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(18),
                          color: const Color(0xffF3F3F3),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add_box_rounded),
                            SizedBox(width: 8),
                            Text(
                              'Thêm Sản phẩm',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Product List with BLoC Builder
                Expanded(
                  child: BlocBuilder<SellerRegisterProductBloc,
                      SellerRegisterProductBlocState>(
                    builder: (context, state) {
                      if (state is SellerRegisterProductLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SellerRegisterProductLoaded) {
                        final products = state.products;
                        return ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              status: product.status,
                              id: product.id,
                              imageUrl: product.fullImageUrl,
                              productName: product.name,
                              description: product.description,
                              isActive: product.status,
                              quantity: product.quantity,
                              soldQuantity: product.soldQuantity,
                              originalPrice: product.originalPrice,
                              discountPrice: product.discountPrice,
                              discountPercentage: product.discountPercentage,
                              onEdit: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductActiveDetailsScreen(
                                            productId: product.id),
                                  ),
                                );
                                if (result == true) {
                                  if (!context.mounted) return;
                                  context
                                      .read<SellerRegisterProductBloc>()
                                      .add(SellerRegisterProductGetEvent());
                                }
                              },
                              onDelete: () async {
                                // Add delete confirmation dialog
                                final shouldDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Xác nhận xóa'),
                                    content: const Text(
                                        'Bạn có chắc chắn muốn xóa sản phẩm này?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Hủy'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text('Xóa'),
                                      ),
                                    ],
                                  ),
                                );

                                if (shouldDelete == true) {
                                  if (!context.mounted) return;
                                  context
                                      .read<SellerRegisterProductBloc>()
                                      .add(SellerRegisterProductGetEvent());
                                }
                              },
                            );
                          },
                        );
                      } else if (state is SellerRegisterProductError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.message),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<SellerRegisterProductBloc>()
                                      .add(SellerRegisterProductGetEvent());
                                },
                                child: const Text('Thử lại'),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String? id;
  final bool? status;
  final String? imageUrl;
  final String productName;
  final String description;
  final bool isActive;
  final int quantity;
  final int soldQuantity;
  final double originalPrice;
  final double discountPrice;
  final int discountPercentage;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductCard({
    Key? key,
    required this.id,
    required this.status,
    this.imageUrl,
    this.productName = 'Tên sản phẩm',
    this.description = 'Mô tả sản phẩm',
    required this.isActive,
    required this.quantity,
    required this.soldQuantity,
    required this.originalPrice,
    required this.discountPrice,
    required this.discountPercentage,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  String _formatPrice(double price) {
    if (price <= 0) return 'Liên hệ';
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(price)} đ';
  }

  @override
  Widget build(BuildContext context) {
    final price = discountPrice > 0 ? discountPrice : originalPrice;
    final formattedPrice = _formatPrice(price);
    final formattedOriginalPrice = _formatPrice(originalPrice);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {}, // Có thể thêm onTap callback nếu cần
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image with Discount Badge
                Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image(
                          image: imageUrl != null
                              ? NetworkImage(imageUrl!) as ImageProvider
                              : const AssetImage('assets/images/default.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (discountPercentage > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            '-$discountPercentage%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name and ID
                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: $id',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Description
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Status Badges
                      Row(
                        children: [
                          if (status != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: status == true
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: status == true
                                      ? Colors.green
                                      : Colors.orange,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                status == true ? 'Đã lên sàn' : 'Chưa lên sàn',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: status == true
                                      ? Colors.green
                                      : Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(Icons.inventory_2_outlined,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            'SL: $quantity',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.shopping_cart_outlined,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            'Đã bán: $soldQuantity',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            formattedPrice,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (discountPrice > 0) ...[
                            const SizedBox(width: 8),
                            Text(
                              formattedOriginalPrice,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.grey[400],
                                decorationThickness: 2,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onEdit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Thêm thông tin',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: onEdit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Kích hoạt',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: onDelete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Xóa',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterModal extends StatelessWidget {
  const FilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text('Lọc theo loại sản phẩm'),
          trailing: const Icon(Icons.filter_list),
          onTap: () {
            // Implement sorting/filtering logic
          },
        ),
        ListTile(
          title: const Text('Lọc từ A - Z'),
          trailing: const Icon(Icons.sort_by_alpha),
          onTap: () {
            // Implement sorting logic
          },
        ),
        ListTile(
          title: const Text('Lọc từ Z - A'),
          trailing: const Icon(Icons.sort_by_alpha),
          onTap: () {
            // Implement sorting logic
          },
        ),
        ListTile(
          title: const Text('Lọc theo giá giảm dần'),
          trailing: const Icon(Icons.arrow_downward),
          onTap: () {
            // Implement price descending sorting logic
          },
        ),
        ListTile(
          title: const Text('Lọc theo giá tăng dần'),
          trailing: const Icon(Icons.arrow_upward),
          onTap: () {
            // Implement price ascending sorting logic
          },
        ),
      ],
    );
  }
}
