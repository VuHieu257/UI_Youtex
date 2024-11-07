part of 'fetch_user_by_phone_bloc.dart';

@immutable
sealed class FetchUserByPhoneEvent {}

class FetchUserByPhone extends FetchUserByPhoneEvent {
  final String phone;

  FetchUserByPhone(this.phone);
}
