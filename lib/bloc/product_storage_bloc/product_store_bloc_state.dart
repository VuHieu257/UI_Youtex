part of 'product_store_bloc.dart';

abstract class ProductStoreBlocState extends Equatable {
  const ProductStoreBlocState();

  @override
  List<Object> get props => [];
}

class ProductStoreDetailBlocInitial extends ProductStoreBlocState {}

class ProductStoreDetailLoadingState extends ProductStoreBlocState {}

class ProductStoreDetailLoadedState extends ProductStoreBlocState {
  final List<ProductStore> products;
  final List<ProductStore> filteredProducts;
  final String message;

  const ProductStoreDetailLoadedState({
    required this.products,
    required this.filteredProducts,
    required this.message,
  });

  @override
  List<Object> get props => [products, filteredProducts, message];

  ProductStoreDetailLoadedState copyWith({
    List<ProductStore>? products,
    List<ProductStore>? filteredProducts,
    String? message,
  }) {
    return ProductStoreDetailLoadedState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      message: message ?? this.message,
    );
  }
}

class ProductDetailStoreLoadedState extends ProductStoreBlocState {
  final ProductModel product;
  final String message;

  const ProductDetailStoreLoadedState({
    required this.product,
    required this.message,
  });

  @override
  List<Object> get props => [product, message];
}

class ProductErrorState extends ProductStoreBlocState {
  final String error;

  const ProductErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
