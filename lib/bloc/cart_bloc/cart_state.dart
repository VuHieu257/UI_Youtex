part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartSuccess extends CartState {}
class GetCartSuccess extends CartState {
  final List<Cart> carts;
  GetCartSuccess({required this.carts});
  @override
  List<Object> get props => [carts];
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});

  @override
  List<Object> get props => [message];
}
class CartLoading extends CartState {}

