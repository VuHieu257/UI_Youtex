import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/token_manager.dart';
import 'seller_product_sales_bloc_event.dart';
import 'seller_product_sales_bloc_state.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';

class SellerProductSalesBloc
    extends Bloc<SellerProductSalesBlocEvent, ProductSalesState> {
  final RestfulApiProviderImpl restfulApiProvider;

  SellerProductSalesBloc({required this.restfulApiProvider})
      : super(ProductSalesInitial()) {
    on<PostSellerProductSalesEvent>((event, emit) async {
      emit(ProductSalesLoading());
      try {
        final token = await TokenManager.getToken();

        bool success = await restfulApiProvider.postproductsales(
          token: token!,
          discount_price: event.productSales.discountPrice,
          max_order: event.productSales.maxOrder,
          min_order: event.productSales.minOrder,
          original_price: event.productSales.originalPrice,
          product_id: event.productSales.productId,
          quantity: event.productSales.quantity,
          size_chart: event.productSales.sizeChart!,
        );
        if (success) {
          emit(ProductSalesSuccess("Product posted successfully."));
        } else {
          emit(ProductSalesError("Failed to post product."));
        }
      } catch (e) {
        emit(ProductSalesError(e.toString()));
      }
    });
  }
}
