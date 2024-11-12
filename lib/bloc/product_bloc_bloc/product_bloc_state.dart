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
  final String message;

  const ProductLoadedState({
    required this.products,
    required this.message,
  });

  @override
  List<Object> get props => [products, message];
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
