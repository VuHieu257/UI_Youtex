part of 'fetch_user_by_phone_bloc.dart';

abstract class FetchUserByPhoneState {}

class FetchUserByPhoneInitial extends FetchUserByPhoneState {}

class UserLoading extends FetchUserByPhoneState {}

class UserLoaded extends FetchUserByPhoneState {
  final String id;
  final String name;
  final String? img;
  final String phone;

  UserLoaded({required this.id, required this.name, this.img, required this.phone});
}

class UserError extends FetchUserByPhoneState {
  final String message;

  UserError(this.message);
}
