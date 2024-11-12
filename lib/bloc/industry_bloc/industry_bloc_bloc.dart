import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ui_youtex/model/industry.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/token_manager.dart';

part 'industry_bloc_event.dart';
part 'industry_bloc_state.dart';

class IndustryBloc extends Bloc<IndustryEvent, IndustryState> {
  final RestfulApiProviderImpl restfulApiProvider;

  IndustryBloc({required this.restfulApiProvider}) : super(IndustryInitial()) {
    on<LoadIndustries>(_onLoadIndustries);
    on<RefreshIndustries>(_onRefreshIndustries);
  }

  Future<void> _onLoadIndustries(
    LoadIndustries event,
    Emitter<IndustryState> emit,
  ) async {
    try {
      final token = await TokenManager.getToken();

      emit(IndustryLoading());
      final industries =
          await restfulApiProvider.fetchIndustryBuyer(token: token!);
      emit(IndustryLoaded(industries));
    } catch (e) {
      emit(IndustryError(e.toString()));
    }
  }

  Future<void> _onRefreshIndustries(
    RefreshIndustries event,
    Emitter<IndustryState> emit,
  ) async {
    try {
      final token = await TokenManager.getToken();

      final industries =
          await restfulApiProvider.fetchIndustryBuyer(token: token!);
      emit(IndustryLoaded(industries));
    } catch (e) {
      emit(IndustryError(e.toString()));
    }
  }
}
