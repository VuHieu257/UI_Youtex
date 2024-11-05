part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SubmitRegister extends RegisterEvent {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String passwordConfirmation;

  const SubmitRegister({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [name, phone, email, password, passwordConfirmation];
}