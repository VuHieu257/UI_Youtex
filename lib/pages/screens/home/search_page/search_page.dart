import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc/product_bloc_bloc/product_bloc_bloc.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/pages/screens/home/product/product_detail_page.dart';
import 'package:ui_youtex/pages/widget_small/product/product_card.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import '../../shopping_cart_page/shopping_cart_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

final TextEditingController searchController = TextEditingController();

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBlocBloc(
            restfulApiProvider: context.read<RestfulApiProviderImpl>(),
          )..add(FetchProductsEvent()),
        ),
      ],
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 10,
                right: 10,
                bottom: 15,
              ),
              color: Styles.blue,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (query) {
                        print('Search Query from UI: $query');
                        if (query.isNotEmpty) {
                          context
                              .read<ProductBlocBloc>()
                              .add(SearchProductsEvent(query));
                        } else {
                          context
                              .read<ProductBlocBloc>()
                              .add(FetchProductsEvent());
                        }
                        setState(
                            () {}); // Thêm dòng này để kiểm tra việc làm mới UI
                      },
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShoppingCartPage(),
                      ),
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Styles.light,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductBlocBloc, ProductBlocState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductLoadedState) {
                    print('UI Updated with Products: ${state.products}');
                    // Kiểm tra số lượng sản phẩm hiển thị
                    print('Product Count: ${state.products.length}');
                    if (state.products.isNotEmpty) {
                      return _buildProductGrid(context, state);
                    } else {
                      return const Center(
                        child: Text('No products found for your search'),
                      );
                    }
                  } else if (state is ProductErrorState) {
                    return Center(
                      child: Text('Error: ${state.error}'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, ProductBlocState state) {
    if (state is ProductLoadedState) {
      return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final product = state.products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
            child: ProductCard(product: product),
          );
        },
      );
    } else {
      return const Center(
        child: Text('No products available'),
      );
    }
  }
}
