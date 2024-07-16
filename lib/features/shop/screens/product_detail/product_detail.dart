import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/bottom_add_to_cart_widget.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/product_attribute.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/product_detail_image_slider.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/product_meta_data.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/product_rating_and_share.dart';

import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/product_detail_controller.dart';
import '../../models/product_detail_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailController productDetailController = Get.put(ProductDetailController());
  ProductDetailScreen({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    productDetailController.fetchProductDetail(productId);

    return Scaffold(
      bottomNavigationBar:  TBottomAddToCart(product: productDetailController),
      body: Obx(() {
        if (productDetailController.productDetail.value.packageId == 0) {
          return const Center(child: CircularProgressIndicator());
        } else {
          ProductDetailModel product =
              productDetailController.productDetail.value;
          return SingleChildScrollView(
            child: Column(
              children: [
                /// 1 - Product Image Slider
                TProductImageSlider(product: product),

                /// 2 - Product Details
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace,
                      vertical: TSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Rating & Share Button
                      const TRatingAndShare(),

                      /// Price, Title, Stock, & Brand
                      TProductMetaData(product: product),

                      /// Attributes
                      TProductAttributes(product: product),

                      /// Checkout Button
                      /// Description
                      /// Reviews
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
