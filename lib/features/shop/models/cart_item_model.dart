class CartItemModel {
  int packageId;
  String packageName;
  double packagePrice;
  String packageThumbnailUrl;
  int quantity;
  String packageType;

  CartItemModel({
    required this.packageId,
    required this.packageName,
    required this.packagePrice,
    required this.packageThumbnailUrl,
    required this.quantity,
    required this.packageType,
  });

  static CartItemModel fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      packageId: json['packageId'] is String ? int.parse(json['packageId']) : json['packageId'],
      packageName: json['packageName'],
      packagePrice: json['packagePrice'] is String ? double.parse(json['packagePrice']) : json['packagePrice'],
      packageThumbnailUrl: json['packageThumbnailUrl'],
      quantity: json['quantity'] is String ? int.parse(json['quantity']) : json['quantity'],
      packageType: json['packageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'packageId': packageId,
      'packageName': packageName,
      'packagePrice': packagePrice,
      'packageThumbnailUrl': packageThumbnailUrl,
      'quantity': quantity,
      'packageType': packageType,
    };
  }
}
