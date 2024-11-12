import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/bloc/industry_bloc/industry_bloc_bloc.dart';
import 'package:ui_youtex/bloc/product_bloc_bloc/product_bloc_bloc.dart';
import 'package:ui_youtex/core/size/size.dart';
import 'package:ui_youtex/core/themes/theme_extensions.dart';
import 'package:ui_youtex/model/industry.dart';
import 'package:ui_youtex/pages/screens/home/product/product_detail_page.dart';
import 'package:ui_youtex/pages/screens/home/search_page/search_page.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/constants.dart';
import '../../../core/assets.dart';
import '../../widget_small/product/product_card.dart';
import '../shopping_cart_page/shopping_cart_page.dart';
import 'category/category_screen.dart';

class HomeMall extends StatelessWidget {
  HomeMall({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBlocBloc(
            restfulApiProvider: context.read<RestfulApiProviderImpl>(),
          )..add(const FetchProductsEvent()),
        ),
        BlocProvider(
          create: (context) => IndustryBloc(
            restfulApiProvider: context.read<RestfulApiProviderImpl>(),
          )..add(LoadIndustries()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset(
                Asset.bgLogo,
                height: 40,
              ),
            ],
          ),
          actions: [
            _buildIconButton(
              context: context,
              icon: Icons.search,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              ),
            ),
            _buildIconButton(
              context: context,
              icon: Icons.shopping_cart_outlined,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ShoppingCartPage()),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(context),
              BlocBuilder<IndustryBloc, IndustryState>(
                builder: (context, state) {
                  if (state is IndustryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is IndustryLoaded) {
                    return _buildIndustrySection(context, state.industries);
                  } else if (state is IndustryError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return SizedBox.shrink();
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              ),
              _buildProductSectionTitle(context),
              BlocBuilder<ProductBlocBloc, ProductBlocState>(
                builder: (context, state) {
                  return _buildProductGrid(context, state);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildIndustrySection(
      BuildContext context, List<Industry> industries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Danh mục',
            style: context.theme.textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: context.width * 0.32,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: industries.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         CategoryScreen(category: industries[index].name),
                //   ),
                // ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "${NetworkConstants.urlImage}/storage/${industries[index].image}"),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: context.width * 0.2,
                        child: Text(
                          industries[index].name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.theme.textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: context.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage(Asset.bgSlider),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildProductSectionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        'Sản phẩm',
        style: context.theme.textTheme.headlineMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, ProductBlocState state) {
    if (state is ProductLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ProductLoadedState) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
            child: ProductCard(product: product), // Uncomment this line
          );
        },
      );
    } else if (state is ProductErrorState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Error: ${state.error}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text('No products available'),
      );
    }
  }
}
