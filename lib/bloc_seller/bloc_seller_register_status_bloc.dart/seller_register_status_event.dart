part of 'seller_register_status_bloc.dart';

@immutable
sealed class SellerRegisterStatusEvent {}
class GetSellerStatusEvent extends SellerRegisterStatusEvent {}
