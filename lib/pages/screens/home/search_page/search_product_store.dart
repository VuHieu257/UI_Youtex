import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc/product_storage_bloc/product_store_bloc.dart';
import 'package:ui_youtex/core/colors/color.dart';
import 'package:ui_youtex/pages/screens/home/product/product_store_detail_page.dart';
import 'package:ui_youtex/pages/screens/home/product/product_detail_page.dart';
import 'package:ui_youtex/pages/widget_small/product/product_card.dart';
import 'package:ui_youtex/pages/widget_small/product/product_cart.dart';
import '../../shopping_cart_page/shopping_cart_page.dart';

class SearchProductStorage extends StatefulWidget {
  final String storeUuid; // Add store UUID parameter

  const SearchProductStorage({
    super.key,
    required this.storeUuid, // Make it required
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchProductStorage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch products when widget initializes
    context.read<ProductStoreBlocBloc>().add(
          FetchProductsEvent(uuid: widget.storeUuid),
        );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductStoreBlocBloc, ProductStoreBlocState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchHeader(context),
              Expanded(
                child: _buildProductContent(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 10,
        bottom: 15,
      ),
      color: Styles.blue,
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                context.read<ProductStoreBlocBloc>().add(
                      SearchProductsEvent(query),
                    );
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
    );
  }

  Widget _buildProductContent(ProductStoreBlocState state) {
    if (state is ProductStoreDetailLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProductStoreDetailLoadedState) {
      return state.filteredProducts.isEmpty
          ? const Center(child: Text('Không tìm thấy sản phẩm nào'))
          : _buildProductGrid(state.filteredProducts);
    } else if (state is ProductErrorState) {
      return Center(child: Text(state.error));
    }
    return const Center(child: Text('Vui lòng thử lại sau'));
  }

  Widget _buildProductGrid(List<ProductStore> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            if (product.uuid != null) {
              context.read<ProductStoreBlocBloc>().add(
                    ProductDetailBuyerEvent(uuId: product.uuid!),
                  );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductStoreDetailPage(product: product),
                ),
              );
            }
          },
          child: ProductCardStore(product: product),
        );
      },
    );
  }
}
