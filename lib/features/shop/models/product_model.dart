class ProductModel {
   int packageId;
   String packageName;
   double packagePrice;
   String packageType;
   String packageThumbnailUrl;

  ProductModel({
    required this.packageId,
    required this.packageName,
    required this.packagePrice,
    required this.packageType,
    required this.packageThumbnailUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      packageId: json['package_id'],
      packageName: json['package_name'],
      packagePrice: json['package_price'],
      packageType: json['package_type'],
      packageThumbnailUrl: json['package_thumbnail_url'],
    );
  }

   Map<String, dynamic> toJson() {
     return {
       'package_id': packageId,
       'package_name': packageName,
       'package_price': packagePrice,
       'package_type': packageType,
       'package_thumbnail_url': packageThumbnailUrl,
     };
   }
}
