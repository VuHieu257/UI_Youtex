import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ui_youtex/model/product_model.dart';
import 'package:ui_youtex/services/restful_api_provider.dart';
import 'package:ui_youtex/util/constants.dart';
import 'package:ui_youtex/util/token_manager.dart';

part 'product_bloc_event.dart';

part 'product_bloc_state.dart';

class ProductBlocBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  final RestfulApiProviderImpl restfulApiProvider;

  ProductBlocBloc({required this.restfulApiProvider})
      : super(ProductBlocInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<SearchProductsEvent>(_onSearchProducts);

    on<ProductDetailBuyer>(_onFetchProductDetail);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductBlocState> emit,
  ) async {
    try {
      emit(ProductLoadingState());
      final token = await TokenManager.getToken();

      if (token == null) {
        emit(const ProductErrorState(error: 'Token not found'));
        return;
      }

      final products = await restfulApiProvider.fetchProductBuyer(token: token);

      emit(ProductLoadedState(
        products: products,
        filteredProducts: const [],
        message: 'Lấy danh sách sản phẩm thành công!',
      ));
    } catch (error) {
      emit(ProductErrorState(error: error.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<ProductBlocState> emit,
  ) async {
    if (state is ProductLoadedState) {
      final currentState = state as ProductLoadedState;
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
    ProductDetailBuyer event,
    Emitter<ProductBlocState> emit,
  ) async {
    try {
      emit(ProductLoadingState());
      final token = await TokenManager.getToken();

      if (token == null) {
        emit(const ProductErrorState(error: 'Token not found'));
        return;
      }

      final productDetail = await restfulApiProvider.fetchProductDetailBuyer(
        token: token,
        uuid: event.uuId,
      );

      emit(ProductDetailLoadedState(
          product: productDetail,
          message: 'Lấy chi tiết sản phẩm thành công!'));
    } catch (error) {
      emit(ProductErrorState(error: error.toString()));
    }
  }
}
