class OrderModel {
  final int deliveryOrderId;
  final DateTime orderDate;
  final double orderValue;
  final String? shipperDate;
  final String shippedAddress;
  final String orderCode;
  final String orderContactPhone;
  final double shippingFee;
  final String orderStatus;
  final String orderPaymentMethod;
  final List<OrderDetailModel> orderDetail;

  OrderModel({
    required this.deliveryOrderId,
    required this.orderDate,
    required this.orderValue,
    required this.shipperDate,
    required this.shippedAddress,
    required this.shippingFee,
    required this.orderStatus,
    required this.orderPaymentMethod,
    required this.orderDetail,
    required this.orderCode,
    required this.orderContactPhone,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      deliveryOrderId: json['delivery_order_id'],
      orderDate: DateTime.parse(json['order_date']),
      orderValue: json['order_value'].toDouble(),
      shipperDate: json['shipper_date'],
      shippedAddress: json['shipped_address'],
      shippingFee: json['shipping_fee'].toDouble(),
      orderStatus: json['order_status'],
      orderPaymentMethod: json['order_payment_method'],
      orderCode: json['order_code'],
      orderContactPhone: json['user_phone'],
      orderDetail: List<OrderDetailModel>.from(
          json['order_detail'].map((item) => OrderDetailModel.fromJson(item))),
    );
  }
}

class OrderDetailModel {
  final int orderDetailId;
  final int packageId;
  final String packageName;
  final int packageQuantity;
  final double packagePrice;
  final String packageThumbnailUrl;

  OrderDetailModel({
    required this.orderDetailId,
    required this.packageId,
    required this.packageName,
    required this.packageQuantity,
    required this.packagePrice,
    required this.packageThumbnailUrl,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      orderDetailId: json['order_detail_id'],
      packageId: json['package_id'],
      packageName: json['package_name'],
      packageQuantity: json['package_quantity'],
      packagePrice: json['package_price'].toDouble(),
      packageThumbnailUrl: json['package_thumbnail_url'],
    );
  }
}
