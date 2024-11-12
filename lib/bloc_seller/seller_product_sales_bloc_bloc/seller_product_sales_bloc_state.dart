import 'package:equatable/equatable.dart';

abstract class ProductSalesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductSalesInitial extends ProductSalesState {}

class ProductSalesLoading extends ProductSalesState {}

class ProductSalesSuccess extends ProductSalesState {
  final String message;

  ProductSalesSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductSalesError extends ProductSalesState {
  final String error;

  ProductSalesError(this.error);

  @override
  List<Object?> get props => [error];
}
