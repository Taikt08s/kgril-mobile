class CheckoutModel {
  int deliveryOrderId;
  double orderValue;
  String shippedAddress;
  double orderLatitude;
  double orderLongitude;
  double shippingFee;
  String orderPaymentMethod;

  CheckoutModel({
    required this.deliveryOrderId,
    required this.orderValue,
    required this.shippedAddress,
    required this.orderLatitude,
    required this.orderLongitude,
    required this.shippingFee,
    required this.orderPaymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'delivery_order_id': deliveryOrderId,
      'order_value': orderValue,
      'shipped_address': shippedAddress,
      'order_latitude': orderLatitude,
      'order_longitude': orderLongitude,
      'shipping_fee': shippingFee,
      'order_payment_method': orderPaymentMethod,
    };
  }
}
