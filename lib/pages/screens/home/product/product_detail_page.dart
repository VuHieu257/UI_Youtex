import 'package:flutter/material.dart';
import 'package:ui_youtex/bloc/product_bloc_bloc/product_bloc_bloc.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/shopping_cart_page.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductBuyer product;

  const ProductDetailPage({super.key, required this.product});

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
          ),
        ),
        title: Text(
          'Chi tiết sản phẩm',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Styles.light,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Styles.light,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShoppingCartPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  image: DecorationImage(
                    image: NetworkImage(product.fullImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImageIndicator(isActive: true),
                    _buildImageIndicator(),
                    _buildImageIndicator(),
                    _buildImageIndicator(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                '${product.originalPrice}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.blue),
              ),
              const SizedBox(height: 8),
              _buildRatingsAndReviewCount(),
              const SizedBox(height: 16),
              const Divider(),
              _buildSellerInfo(context),
              const Divider(),
              const SizedBox(height: 16),
              _buildQuantitySelector(context),
              const SizedBox(height: 16),
              _buildColorOptions(context),
              const SizedBox(height: 10),
              _buildProductDescription(context),
              const SizedBox(height: 16),
              _buildReviewsSection(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildImageIndicator({bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Styles.blue : Styles.light,
      ),
    );
  }

  Row _buildRatingsAndReviewCount() {
    return Row(
      children: [
        const Icon(Icons.star, color: Styles.nearPrimary, size: 16),
        const Icon(Icons.star, color: Styles.nearPrimary, size: 16),
        const Icon(Icons.star, color: Styles.nearPrimary, size: 16),
        const Icon(Icons.star, color: Styles.nearPrimary, size: 16),
        const Icon(Icons.star_half, color: Styles.nearPrimary, size: 16),
        const SizedBox(width: 8),
        Text('4.7 (143 Reviews)'),
        const SizedBox(width: 8),
        Text('Đã bán: 63'),
      ],
    );
  }

  Row _buildSellerInfo(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(
              'assets/images/avatar.png'), // Placeholder for user image
          radius: 25,
        ),
        const SizedBox(width: 10),
        Text(
          'Phan Hiền',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Spacer(),
        _buildFollowButton(context),
        _buildMessageButton(context),
      ],
    );
  }

  Container _buildFollowButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Styles.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Theo dõi',
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.white),
      ),
    );
  }

  Container _buildMessageButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Styles.blue),
      ),
      child: Text(
        'Nhắn tin',
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.black87),
      ),
    );
  }

  Row _buildQuantitySelector(BuildContext context) {
    return Row(
      children: [
        Text(
          'Số lượng',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {},
              ),
              Text('1'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Wrap _buildColorOptions(BuildContext context) {
    return Wrap(
      children: [
        _buildColorOption(context, "xanh navy", true),
        _buildColorOption(context, "Xanh Lá Mạ", false),
        _buildColorOption(context, "Đỏ", false),
      ],
    );
  }

  Container _buildColorOption(
      BuildContext context, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? Styles.blue : Styles.light,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
          )
        ],
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: isSelected ? Styles.light : Styles.dark,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Column _buildProductDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giới thiệu về sản phẩm này',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Column _buildReviewsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Đánh giá',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Divider(),
        Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/avatar.png'), // Placeholder for user image
              radius: 15,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User1"),
                Row(
                  children: const [
                    Icon(Icons.star, color: Styles.nearPrimary, size: 16),
                    Icon(Icons.star, color: Styles.nearPrimary, size: 16),
                    Icon(Icons.star, color: Styles.nearPrimary, size: 16),
                    Icon(Icons.star, color: Styles.nearPrimary, size: 16),
                    Icon(Icons.star_half, color: Styles.nearPrimary, size: 16),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Hàng giao đúng mô tả, chất lượng tuyệt vời!',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Container _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Styles.light,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildBottomButton(
              context,
              title: 'Thêm vào giỏ hàng',
              backgroundColor: Colors.grey,
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildBottomButton(
              context,
              title: 'Mua ngay',
              backgroundColor: Styles.blue,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBottomButton(BuildContext context,
      {required String title,
      required Color backgroundColor,
      required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
