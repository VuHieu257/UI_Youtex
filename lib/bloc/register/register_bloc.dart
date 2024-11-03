import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/bloc/register/register_state.dart';

import '../../services/restful_api_provider.dart';

part 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  RegisterBloc() : super(RegisterInitial()) {
    on<SubmitRegister>(_onRegister);
  }
  final RestfulApiProviderImpl _restfulApiProviderImpl =
  RestfulApiProviderImpl();
  Future<void> _onRegister(
      SubmitRegister event,
      Emitter<RegisterState> emit,
      ) async {
    emit(RegisterLoading());
    try {
      final response = await _restfulApiProviderImpl.register(
        name: event.name,
        phone: event.phone,
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );
      if (response.statusCode == 201) {
        emit(RegisterSuccess(response.data["message"] ?? "Đăng ký thành công!"));
      } else {
        emit(const RegisterFailure(error:'Failed to register'));
      }
    } on DioException catch (e) {
      final errors = e.response?.data['errors'];
      final emailError = errors['email']?[0];
      final passwordError = errors['password']?[0];
      final nameError = errors['name']?[0];

      emit(RegisterFailure(
        emailError: emailError,
        passwordError: passwordError,
        nameError:nameError,
      ));
      emit(RegisterInitial());
    }catch (error) {
      emit(RegisterFailure(error: error.toString()));
    }
  }
}