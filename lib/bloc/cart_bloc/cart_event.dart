part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String uuid;
  final String colorId;
  final String sizeId;
  final String quantity;

  AddToCartEvent( {required this.uuid,required this.quantity,required this.colorId,required this.sizeId});

  @override
  List<Object> get props => [uuid];
}
class FetchCartEvent extends CartEvent {}