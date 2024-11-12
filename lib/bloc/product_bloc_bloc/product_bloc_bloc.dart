import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
          products: products, message: 'Lấy danh sách sản phẩm thành công!'));
    } catch (error) {
      emit(ProductErrorState(error: error.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
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

      // In chi tiết từng sản phẩm để kiểm tra
      print('Search Query: ${event.searchQuery}');
      for (var product in products) {
        print('Product Name: ${product.name}');
      }

      // Lọc sản phẩm
      final filteredProducts = products
          .where((product) => product.name
              .toLowerCase()
              .contains(event.searchQuery.toLowerCase()))
          .toList();

      print(
          'Filtered Products: $filteredProducts'); // In ra kết quả sau khi lọc

      emit(ProductLoadedState(
          products: List.from(filteredProducts),
          message: 'Tìm kiếm sản phẩm thành công!'));
    } catch (error) {
      emit(ProductErrorState(error: error.toString()));
    }
  }
}
