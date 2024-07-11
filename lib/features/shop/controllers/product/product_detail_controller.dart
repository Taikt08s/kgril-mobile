import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kgrill_mobile/data/services/shop/product_detail_service.dart';

import 'package:kgrill_mobile/features/shop/models/product_detail_model.dart';


class ProductDetailController extends GetxController {
  final ProductDetailService productService = Get.put(ProductDetailService());
  Rx<ProductDetailModel> productDetail = ProductDetailModel(
    packageId: 0,
    packageName: '',
    packagePrice: 0.0,
    packageType: '',
    packageDescription: '',
    packageSize: '',
    packageThumbnailUrl: '',
    dishes: [],
  ).obs;

  void fetchProductDetail(int productId) async {
    try {
      var product = await productService.fetchProductDetail(productId);
      productDetail.value = product;
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('Error fetching product detail: $e');
      }
    }
  }
}
