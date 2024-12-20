import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

part 'seller_register_tax_get_bloc_event.dart';
part 'seller_register_tax_get_bloc_state.dart';

class SellerRegisterTaxBloc
    extends Bloc<SellerRegisterTaxBlocEvent, SellerRegisterTaxBlocState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerRegisterTaxBloc({required this.restfulApiProvider})
      : super(SellerRegisterTaxInitial()) {
    on<SellerRegisterTaxGetBlocEvent>(_onGetTax);
    on<SellerRegisterTaxPostBlocEvent>(_onPostTax);
  }

  Future<void> _onGetTax(
    SellerRegisterTaxGetBlocEvent event,
    Emitter<SellerRegisterTaxBlocState> emit,
  ) async {
    emit(SellerRegisterTaxLoading());
    try {
      if (event.model != null) {
        emit(SellerRegisterTaxLoaded(event.model!));
      } else {
        final token = await TokenManager.getToken();

        final response = await restfulApiProvider.getTax(token: token!);
        if (response.statusCode == 200) {
          final tax = SellerRegisterTaxModel.fromJson(response.data);
          emit(SellerRegisterTaxLoaded(tax));
        } else {
          emit(SellerRegisterTaxCreatePrompt(
              'No tax information found. Please create tax information.'));
        }
      }
    } catch (e) {
      emit(SellerRegisterTaxError(e.toString()));
    }
  }

  Future<void> _onPostTax(
    SellerRegisterTaxPostBlocEvent event,
    Emitter<SellerRegisterTaxBlocState> emit,
  ) async {
    emit(SellerRegisterTaxLoading());
    try {
      final token = await TokenManager.getToken();

      final success =
          await restfulApiProvider.postTax(event.model, token: token!);
      if (success) {
        emit(SellerRegisterTaxLoaded(event.model));
      } else {
        emit(SellerRegisterTaxError('Failed to update tax information'));
      }
    } catch (e) {
      emit(SellerRegisterTaxError(e.toString()));
    }
  }
}
