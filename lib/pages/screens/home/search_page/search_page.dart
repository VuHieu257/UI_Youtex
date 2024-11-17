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

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBlocBloc(
            restfulApiProvider: context.read<RestfulApiProviderImpl>(),
          )..add(const FetchProductsEvent()),
        ),
      ],
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button and search bar container
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
                  // Back button
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Go back when tapped
                    },
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  SizedBox(
                      width: 10), // Space between back button and search bar
                  // Search bar
                  Expanded(
                    child: BlocBuilder<ProductBlocBloc, ProductBlocState>(
                      builder: (context, state) {
                        return TextField(
                          controller: searchController,
                          onChanged: (query) {
                            if (query.isEmpty) {
                              context
                                  .read<ProductBlocBloc>()
                                  .add(const FetchProductsEvent());
                            } else {
                              context
                                  .read<ProductBlocBloc>()
                                  .add(SearchProductsEvent(query));
                            }
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
                        );
                      },
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
                    final productsToShow = state.filteredProducts.isEmpty
                        ? state.products
                        : state.filteredProducts;

                    if (productsToShow.isEmpty) {
                      return const Center(
                        child: Text('Không tìm thấy sản phẩm nào'),
                      );
                    }
                    return _buildProductGrid(state.copyWith(
                      filteredProducts: productsToShow,
                    ));
                  } else if (state is ProductErrorState) {
                    return Center(
                      child: Text('Error: ${state.error}'),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductGrid(ProductLoadedState state) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      // Sử dụng filteredProducts thay vì products
      itemCount: state.filteredProducts.length,
      itemBuilder: (context, index) {
        final product = state.filteredProducts[index];
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
  }
}
