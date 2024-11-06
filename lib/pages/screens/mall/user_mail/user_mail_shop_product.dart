import 'package:flutter/material.dart';
import 'package:ui_youtex/core/assets.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/pages/screens/mall/user_mail/user_mail_shop_productmanager_add.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';

import '../../../../bloc_seller/seller_register_product_bloc_bloc/seller_register_product_bloc_bloc.dart';

class ProductManagementScreen extends StatelessWidget {
  const ProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellerRegisterProductBloc(
        restfulApiProvider: context.read<RestfulApiProviderImpl>(),
      )..add(SellerRegisterProductGetEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Styles.nearPrimary),
            onPressed: () => Navigator.pop(context),
          ),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductaddScreen()),
                );
              },
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
            const SizedBox(
              height: 10,
            ),

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
                          imageUrl: product
                              .fullImageUrl, // Chắc chắn rằng trường này chứa đường dẫn đến ảnh
                          productName: product.name,
                          description: product.description,
                          isActive: product.isActive ==
                              1, // Chuyển đổi từ 0/1 sang bool
                          quantity: product.quantity,
                          soldQuantity: product.soldQuantity,
                          originalPrice: product.originalPrice,
                          discountPrice: product.discountPrice,
                          discountPercentage: product.discountPercentage,
                          onEdit: () {
                            // Handle edit action
                          },
                          onDelete: () {
                            // Handle delete action
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
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
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
    super.key,
    this.imageUrl,
    this.productName = 'Tên sản phẩm',
    this.description = 'Mô tả sản phẩm',
    required this.isActive,
    this.quantity = 0,
    this.soldQuantity = 0,
    this.originalPrice = 0.0,
    this.discountPrice = 0.0,
    this.discountPercentage = 0,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final price = discountPrice > 0 ? discountPrice : originalPrice;
    final formattedPrice = price > 0 ? '$price đ' : 'Liên hệ';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageUrl != null
                    ? NetworkImage(imageUrl!) as ImageProvider
                    : const AssetImage(Asset.bgImageCategory),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Trạng thái: ${isActive ? "Đang bán" : "Ngừng bán"}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Số lượng: $quantity',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Đã bán: $soldQuantity',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Giá: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      formattedPrice,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: onEdit,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'Chỉnh sửa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: onDelete,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text(
                  'Xóa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
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
          onTap: () {
            // Implement sorting/filtering logic
          },
        ),
        ListTile(
          title: const Text('Lọc từ A - Z'),
          onTap: () {
            // Implement sorting logic
          },
        ),
        ListTile(
          title: const Text('Lọc từ Z - A'),
          onTap: () {
            // Implement sorting logic
          },
        ),
      ],
    );
  }
}
