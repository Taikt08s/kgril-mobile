class CartItemModel {
  int orderDetailId;
  int packageId;
  String packageName;
  String packageType;
  String packageSize;
  double packagePrice;
  String packageThumbnailUrl;
  int packageQuantity;

  CartItemModel({
    required this.orderDetailId,
    required this.packageId,
    required this.packageName,
    required this.packageType,
    required this.packageSize,
    required this.packagePrice,
    required this.packageThumbnailUrl,
    required this.packageQuantity,
  });

  static CartItemModel fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      orderDetailId: json['order_detail_id'],
      packageId: json['package_id'],
      packageName: json['package_name'],
      packagePrice: (json['package_price'] as num).toDouble(),
      packageThumbnailUrl: json['package_thumbnail_url'] ?? '',
      packageQuantity: json['package_quantity'],
      packageType: json['package_type'],
      packageSize: json['package_size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_detail_id': orderDetailId,
      'package_id': packageId,
      'package_name': packageName,
      'package_type': packageType,
      'package_size': packageType,
      'package_price': packagePrice,
      'package_thumbnail_url': packageThumbnailUrl,
      'package_quantity': packageQuantity,
    };
  }
}
