import 'package:flutter/material.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/bottom_add_to_cart_widget.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/product_attribute.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/product_detail_image_slider.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/product_meta_data.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/product_rating_and_share.dart';

import '../../../../utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1 - Product Image Slider
            TProductImageSlider(),

            /// 2 - Product Details
            Padding(
              padding: EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Rating & Share Button
                  TRatingAndShare(),

                  /// Price, Title, Stock, & Brand
                  TProductMetaData(),

                  /// Attributes
                  TProductAttributes(),

                  /// Checkout Button
                  /// Description
                  /// Reviews
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
