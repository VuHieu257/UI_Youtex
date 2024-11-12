part of 'product_bloc_bloc.dart';

sealed class ProductBlocState extends Equatable {
  const ProductBlocState();

  @override
  List<Object> get props => [];
}

class ProductBlocInitial extends ProductBlocState {}

class ProductLoadingState extends ProductBlocState {}

class ProductLoadedState extends ProductBlocState {
  final List<ProductBuyer> products;
  final List<ProductBuyer> filteredProducts;
  final String message;

  const ProductLoadedState({
    // required this.products,
    // required this.message,
    required this.products,
    required this.filteredProducts,
    required this.message,
  });

  @override
  List<Object> get props => [products, filteredProducts, message];

  ProductLoadedState copyWith({
    List<ProductBuyer>? products,
    List<ProductBuyer>? filteredProducts,
    String? message,
  }) {
    return ProductLoadedState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      message: message ?? this.message,
    );
  }
}

class ProductDetailLoadedState extends ProductBlocState {
  final ProductModel product;
  final String message;

  const ProductDetailLoadedState({
    required this.product,
    required this.message,
  });

  @override
  List<Object> get props => [product, message];
}

class ProductErrorState extends ProductBlocState {
  final String error;

  const ProductErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
