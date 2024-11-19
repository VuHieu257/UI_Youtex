import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ui_youtex/bloc/product_bloc_bloc/product_bloc_bloc.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/shopping_cart_page/shopping_cart_page.dart';
import 'package:ui_youtex/util/constants.dart';
import 'package:ui_youtex/util/show_snack_bar.dart';

import '../../../../bloc/cart_bloc/cart_bloc.dart';
import '../../../../bloc_seller/seller_product_details_bloc_bloc/seller_product_details_bloc_bloc.dart';
import '../../../../model/colors.dart';
import '../../../../model/product_model.dart';
import '../../../../services/restful_api_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductBuyer product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final apiProvider = RestfulApiProviderImpl();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _quantity = 1;
  int? selectedColorId;
  String errorText = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBlocBloc>(context).add(ProductDetailBuyer(
      uuId: "${widget.product.uuid}",
    ));
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  void textErrorCart() {
    BlocProvider.of<CartBloc>(context).stream.listen((CartState state) {
      if (mounted) {
        if (state is CartError) {
          setState(() {
            errorText = (state.message ?? "null");
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          SnackBarUtils.showWarningSnackBar(context, message: "Có lỗi xảy ra");
        }
        if (state is CartSuccess) {
          SnackBarUtils.showSuccessSnackBar(context,
              message: "Thêm giỏ hàng thành công");
        }
      },
      child: BlocBuilder<ProductBlocBloc, ProductBlocState>(
        builder: (context, state) {
          if (state is ProductLoading) {
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
              body: const Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ProductDetailLoadedState) {
            final product = state.product;
            _quantity = product.minOrder;

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
                      SizedBox(
                        height: context.height * 0.4,
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      product.images[_currentPage]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: PageView.builder(
                                      controller: _pageController,
                                      itemCount: product.images.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          alignment: Alignment.bottomCenter,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(26),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "${NetworkConstants.urlImage}${product.images[index]}"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                                product.images.length, (index) {
                                              return _buildImageIndicator(
                                                  isActive:
                                                      index == _currentPage);
                                            }),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
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
                      Row(
                        children: [
                          Text(
                            "${NumberFormat("#,###").format(int.tryParse(product.discountPrice.split('.').first))}\tđ",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.blue),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${NumberFormat("#,###").format(int.tryParse(product.originalPrice.split('.').first))}\tđ",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(children: [
                        Text("Số lượng:\t${product.quantity}",style: context.theme.textTheme.titleMedium,),
                      ],),
                      // _buildRatingsAndReviewCount(),
                      const SizedBox(height: 16),
                      const Divider(),
                      _buildSellerInfo(
                          context, product.store.image, product.store.name),
                      const Divider(),
                      const SizedBox(height: 16),
                      _buildQuantitySelector(
                          context, product.minOrder, product.maxOrder),
                      const SizedBox(height: 16),
                      _buildColorOptions(context, product.colors),
                      const SizedBox(height: 10),
                      _buildProductDescription(context),
                      const SizedBox(height: 16),
                      // _buildReviewsSection(context),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: _buildBottomNavigationBar(
                context,
                onPressed1: () {
                  BlocProvider.of<CartBloc>(context).add(AddToCartEvent(
                    uuid: product.uuid,
                    quantity: "$_quantity",
                    colorId:
                        product.isOption == 0 ? "" : "${selectedColorId ?? 1}",
                    sizeId:
                        product.isOption == 0 ? "" : "${product.sizes[0].id}",
                  ));
                },
                onPressed2: () {},
              ),
            );
          }
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
            body: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
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
    return const Row(
      children: [
        Icon(Icons.star, color: Styles.nearPrimary, size: 16),
        Icon(Icons.star, color: Styles.nearPrimary, size: 16),
        Icon(Icons.star, color: Styles.nearPrimary, size: 16),
        Icon(Icons.star, color: Styles.nearPrimary, size: 16),
        Icon(Icons.star_half, color: Styles.nearPrimary, size: 16),
        SizedBox(width: 8),
        Text('4.7 (143 Reviews)'),
        SizedBox(width: 8),
        Text('Đã bán: 63'),
      ],
    );
  }

  Row _buildSellerInfo(BuildContext context, String img, String name) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('${NetworkConstants.urlImage}$img'),
          // Placeholder for user image
          radius: 25,
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 150,
          child: Text(
            name,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(overflow: TextOverflow.ellipsis),
          ),
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

  Row _buildQuantitySelector(
      BuildContext context, int minQuantity, int maxQuantity) {
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
                onPressed: _quantity > minQuantity
                    ? () {
                        setState(() {
                          _quantity--;
                        });
                      }
                    : null, // Disable button if quantity is at min
              ),
              Text('$_quantity'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _quantity < maxQuantity
                    ? () {
                        setState(() {
                          _quantity++;
                        });
                      }
                    : null, // Disable button if quantity is at max
              ),
            ],
          ),
        ),
      ],
    );
  }

  Wrap _buildColorOptions(BuildContext context, List<ColorsProduct> colors) {
    return Wrap(
      spacing: 8.0,
      children: colors.map((color) {
        final isSelected = color.id == selectedColorId;
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedColorId = null; // Deselect
              } else {
                selectedColorId = color.id; // Select new color
              }
            });
          },
          child: _buildColorOption(
            context,
            color.name,
            color.hexCode,
            isSelected,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildColorOption(
      BuildContext context, String colorName, String hexCode, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? Styles.blue : Styles.light,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
          width: 2,
        ),
      ),
      child: Text(
        colorName,
        style: TextStyle(
          color: isSelected ? Styles.light : Styles.dark,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
          widget.product.description,
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
        const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/avatar.png'), // Placeholder for user image
              radius: 15,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("User1"),
                Row(
                  children: [
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

  Container _buildBottomNavigationBar(BuildContext context,
      {required void Function() onPressed1,
      required void Function() onPressed2}) {
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
            child: InkWell(
              onTap: onPressed1,
              child: _buildBottomButton(
                context,
                title: 'Thêm vào giỏ hàng',
                backgroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: onPressed2,
              child: _buildBottomButton(
                context,
                title: 'Mua ngay',
                backgroundColor: Styles.blue,
                isCheck: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBottomButton(
    BuildContext context, {
    required String title,
    required Color backgroundColor,
    bool? isCheck,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isCheck == null ? Colors.blue : Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
