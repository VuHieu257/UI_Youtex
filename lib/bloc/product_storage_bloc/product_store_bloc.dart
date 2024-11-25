 
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_youtex/model/product_model.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/constants.dart';

import '../../util/token_manager.dart';

part 'product_store_bloc_event.dart';
part 'product_store_bloc_state.dart';

class ProductStoreBlocBloc
    extends Bloc<ProductStoreBlocEvent, ProductStoreBlocState> {
  final RestfulApiProviderImpl restfulApiProvider;

  ProductStoreBlocBloc({required this.restfulApiProvider})
      : super(ProductStoreDetailBlocInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<SearchProductsEvent>(_onSearchProducts);
    on<ProductDetailBuyerEvent>(_onFetchProductDetail);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductStoreBlocState> emit,
  ) async {
    try {
      emit(ProductStoreDetailLoadingState());
      final token = await TokenManager.getToken();

      if (token == null) {
        emit(const ProductErrorState(error: 'Token not found'));
        return;
      }

       final products = await restfulApiProvider.fetchProductStoreBuyer(
          token: token, uuid:event.uuid); // Replace 'some_uuid' as needed

      emit(ProductStoreDetailLoadedState(
        products: products,
        filteredProducts: products, // Initially all are displayed
        message: 'Lấy danh sách sản phẩm thành công!',
      ));
    } catch (error) {
      emit(ProductErrorState(error: error.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<ProductStoreBlocState> emit,
  ) async {
    if (state is ProductStoreDetailLoadedState) {
      final currentState = state as ProductStoreDetailLoadedState;
      final query = event.searchQuery.toLowerCase();

      if (query.isEmpty) {
        emit(currentState.copyWith(
          filteredProducts: currentState.products,
          message: 'Hiển thị tất cả sản phẩm',
        ));
        return;
      }

      final filtered = currentState.products
          .where((product) => product.name.toLowerCase().contains(query))
          .toList();

      emit(currentState.copyWith(
        filteredProducts: filtered,
        message: 'Tìm thấy ${filtered.length} sản phẩm',
      ));
    }
  }

  Future<void> _onFetchProductDetail(
    ProductDetailBuyerEvent event,
    Emitter<ProductStoreBlocState> emit,
  ) async {
    try {
      emit(ProductStoreDetailLoadingState());
      final token = await TokenManager.getToken();

      if (token == null) {
        emit(const ProductErrorState(error: 'Token not found'));
        return;
      }

      final productDetail = await restfulApiProvider.fetchProductDetailBuyer(
        token: token,
        uuid: event.uuId,
      );

      emit(ProductDetailStoreLoadedState(
        product: productDetail,
        message: 'Lấy chi tiết sản phẩm thành công!',
      ));
    } catch (error) {
      emit(ProductErrorState(error: error.toString()));
    }
  }
}
