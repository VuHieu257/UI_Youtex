abstract class SellerProductShipingEvent {
  const SellerProductShipingEvent();
}

class UpdateSellerProductShipingEvent extends SellerProductShipingEvent {
  final String productId;
  final int? weight;
  final String dimension;

  const UpdateSellerProductShipingEvent({
    required this.productId,
    required this.weight,
    required this.dimension,
  });
}
