part of 'seller_register_bloc.dart';

@immutable
abstract class SellerRegisterState {}

class SellerRegisterInitial extends SellerRegisterState {}

class SellerRegisterLoading extends SellerRegisterState {}

class SellerRegisterSuccess extends SellerRegisterState {}

class SellerRegisterLoaded extends SellerRegisterState {
  final StoreInfo storeInfo; // Đảm bảo kiểu dữ liệu là StoreInfo
  SellerRegisterLoaded(this.storeInfo);
}

class SellerRegisterFailure extends SellerRegisterState {
  final String error;

  SellerRegisterFailure({required this.error});
}
