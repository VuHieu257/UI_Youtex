part of 'seller_product_details_bloc_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final Productdetails product;
  ProductLoaded(this.product);
}

class ProductSuccess extends ProductState {
  final String message;
  ProductSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductError extends ProductState {
  final String error;
  ProductError(this.error);

  @override
  List<Object?> get props => [error];
}
