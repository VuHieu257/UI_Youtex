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

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  void _showMessage(String title, String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$title\n",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: title == 'Thành Công' ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

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
                  child: BlocListener<SellerRegisterProductBloc,
                      SellerRegisterProductBlocState>(
                    listener: (context, state) {
                      if (state is SellerRegisterProductSuccess) {
                        _showMessage('Thành Công', state.message, context);
                      } else if (state is SellerRegisterProductError) {
                        _showMessage('Thất Bại', state.message, context);
                      }
                    },
                    child: BlocBuilder<SellerRegisterProductBloc,
                        SellerRegisterProductBlocState>(
                      builder: (context, state) {
                        if (state is SellerRegisterProductLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is SellerRegisterProductLoaded) {
                          final products = state.products;
                          return ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ProductCard(
                                formattedOriginalPrice: product.discountPrice,
                                formattedPrice: product.originalPrice,
                                price: product.originalPrice,
                                status: product.status,
                                id: product.id,
                                imageUrl: product.fullImageUrl,
                                productName: product.name,
                                description: product.description,
                                quantity: product.quantity,
                                soldQuantity: product.soldQuantity,
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
                                  if (result == true && context.mounted) {
                                    context
                                        .read<SellerRegisterProductBloc>()
                                        .add(SellerRegisterProductGetEvent());
                                  }
                                },
                                onDelete: () async {
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
                                  // if (shouldDelete == true && context.mounted) {
                                  //   context
                                  //       .read<SellerRegisterProductBloc>()
                                  //       .add(SellerRegisterProductDeleteEvent(
                                  //           product.id));
                                  // }
                                },
                                onActive: () async {
                                  final shouldActivate = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => CustomDialogg(
                                      title: 'Kích hoạt sản phẩm',
                                      message:
                                          'Bạn đã bổ sung đủ thông tin sản phẩm yêu cầu chưa?',
                                      onConfirm: () => Navigator.pop(
                                          context, true), // Đóng và xác nhận
                                      onCancel: () => Navigator.pop(
                                          context, false), // Đóng và hủy
                                    ),
                                  );
                                  if (shouldActivate == true &&
                                      context.mounted) {
                                    context
                                        .read<SellerRegisterProductBloc>()
                                        .add(SellerRegisterProductActivateEvent(
                                            product.id));
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
  final String? imageUrl;
  final String productName;
  final String id;
  final String description;
  final int quantity;
  final int soldQuantity;
  final double price;
  final double discountPrice;
  final int discountPercentage;
  final double formattedPrice;
  final double formattedOriginalPrice;
  final VoidCallback onEdit;
  final VoidCallback onActive;

  final VoidCallback onDelete;
  final bool status;

  const ProductCard({
    Key? key,
    this.imageUrl,
    required this.productName,
    required this.id,
    required this.description,
    required this.quantity,
    required this.soldQuantity,
    required this.price,
    required this.discountPrice,
    required this.discountPercentage,
    required this.formattedPrice,
    required this.formattedOriginalPrice,
    required this.onEdit,
    required this.onActive,
    required this.onDelete,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth:
                    MediaQuery.of(context).size.width - 32, // Trừ đi margin
                maxWidth: 800, // Maximum width cho nội dung
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enhanced Product Image
                    Stack(
                      children: [
                        Hero(
                          tag: 'product-$id',
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: imageUrl != null
                                    ? NetworkImage(imageUrl!) as ImageProvider
                                    : const AssetImage(
                                        'assets/images/default.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Status Badge
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: status == true
                                  ? Colors.green.shade600
                                  : Colors.grey[600],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: (status == true
                                          ? Colors.green
                                          : Colors.grey)
                                      .withOpacity(0.2),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  status == true
                                      ? Icons.check_circle
                                      : Icons.pending,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  status == true ? 'Đã lên sàn' : 'Chờ duyệt',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (discountPercentage > 0)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade600,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
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

                    // Enhanced Product Information
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              productName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'ID: $id',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            child: Text(
                              description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Enhanced Stats Row with Horizontal Scroll
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.inventory_2_outlined,
                                      size: 16, color: Colors.blue[700]),
                                  const SizedBox(width: 4),
                                  Text(
                                    'SL: $quantity',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.blue[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(Icons.shopping_cart_outlined,
                                      size: 16, color: Colors.green[700]),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Đã bán: $soldQuantity',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  formattedPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (discountPrice > 0) ...[
                                  const SizedBox(width: 8),
                                  Text(
                                    formattedOriginalPrice.toString(),
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
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildActionButton(
                                onPressed: onEdit,
                                label: 'Thêm',
                                backgroundColor: Colors.blue[600]!,
                                icon: Icons.add,
                              ),
                              const SizedBox(width: 10),
                              _buildActionButton(
                                onPressed: onActive,
                                label: 'Kích hoạt',
                                backgroundColor: Colors.green[600]!,
                                icon: Icons.check_circle_outline,
                              ),
                              const SizedBox(width: 10),
                              _buildActionButton(
                                onPressed: onDelete,
                                label: 'Xóa',
                                backgroundColor: Colors.red[600]!,
                                icon: Icons.delete_outline,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required String label,
    required Color backgroundColor,
    required IconData icon,
  }) {
    return SizedBox(
      width: 110, // Fixed width cho buttons
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        icon: Icon(icon, size: 18),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class CustomDialogg extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const CustomDialogg({
    Key? key,
    required this.title,
    required this.message,
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              title == 'Thành Công' ? Icons.check_circle : Icons.info,
              size: 60,
              color: title == 'Thành Công' ? Colors.green : Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: title == 'Thành Công' ? Colors.green : Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: onCancel ?? () => Navigator.of(context).pop(false),
                  child: const Text('Hủy'),
                ),
                ElevatedButton(
                  onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Kích hoạt',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
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
