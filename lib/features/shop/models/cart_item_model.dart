class CartItemModel {
  int orderDetailId;
  int packageId;
  String packageName;
  double packagePrice;
  String packageThumbnailUrl;
  int packageQuantity;

  CartItemModel({
    required this.orderDetailId,
    required this.packageId,
    required this.packageName,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_detail_id': orderDetailId,
      'package_id': packageId,
      'package_name': packageName,
      'package_price': packagePrice,
      'package_thumbnail_url': packageThumbnailUrl,
      'package_quantity': packageQuantity,
    };
  }
}
