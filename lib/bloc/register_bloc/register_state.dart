import 'package:equatable/equatable.dart';

sealed class RegisterState extends Equatable{
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}


class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;

  const RegisterSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RegisterFailure extends RegisterState {
  final String? error;
  final String? nameError;
  final String? emailError;
  final String? passwordError;

  const RegisterFailure({this.error, this.nameError, this.emailError, this.passwordError});
  String get errorMessage => error ?? 'Đăng nhập thất bại';


}
