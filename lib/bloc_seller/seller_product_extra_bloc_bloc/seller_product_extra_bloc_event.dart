abstract class SellerProductExtraEvent {
  const SellerProductExtraEvent();
}

class UpdateSellerProductExtraEvent extends SellerProductExtraEvent {
  final String productId;
  final String isPreOrder;
  final String status;
  final String sku;

  const UpdateSellerProductExtraEvent({
    required this.productId,
    required this.isPreOrder,
    required this.status,
    required this.sku,
  });
}
