import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../model/order.dart';
import '../../services/restful_api_provider.dart';
import '../../util/token_manager.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final RestfulApiProviderImpl _restfulApiProviderImpl =
  RestfulApiProviderImpl();
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
        if (event is FetchOrders) {
          emit(OrderLoading());
          try {
            final token = await TokenManager.getToken();

            final response = await _restfulApiProviderImpl.getOrder(token: "$token");
            emit(OrderLoaded(response));

          } catch (e) {
            emit(const OrderError('Failed to fetch orders'));
          }
        }
      }
    );
  }
}
