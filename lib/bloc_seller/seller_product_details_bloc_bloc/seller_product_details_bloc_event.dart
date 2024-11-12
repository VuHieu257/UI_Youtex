part of 'seller_product_details_bloc_bloc.dart';

abstract class ProductEvent {}

class FetchProductDetail extends ProductEvent {
  final Productdetails productdetails;
  FetchProductDetail(this.productdetails);
  
}

class Productdetails {
  final String productId;
  final String brand;
  final String gender;
  final String origin;
  final String material;
  final String occasion;
  final String manufacturer;
  final String manufacturerAddress;

  Productdetails(
      {required this.productId,
      required this.brand,
      required this.gender,
      required this.origin,
      required this.material,
      required this.occasion,
      required this.manufacturer,
      required this.manufacturerAddress});
}