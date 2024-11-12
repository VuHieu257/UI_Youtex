import 'package:equatable/equatable.dart';
import 'package:ui_youtex/model/productSales.dart';

abstract class SellerProductSalesBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostSellerProductSalesEvent extends SellerProductSalesBlocEvent {
  final ProductSales productSales;

  PostSellerProductSalesEvent({
    required this.productSales,
  });

  @override
  List<Object?> get props => [productSales];
}

class UpdateSellerProductSalesEvent extends SellerProductSalesBlocEvent {
  final ProductSales productSales;

  UpdateSellerProductSalesEvent({
    required this.productSales,
  });

  @override
  List<Object?> get props => [productSales];
}
