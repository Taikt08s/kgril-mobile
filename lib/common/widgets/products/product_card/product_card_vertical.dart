import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kgrill_mobile/common/widgets/images/t_rounded_image.dart';
import 'package:kgrill_mobile/features/shop/models/product_model.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';
import 'package:kgrill_mobile/utils/constants/sizes.dart';
import 'package:kgrill_mobile/utils/helpers/helper_functions.dart';

import '../../../../features/shop/screens/home/widgets/add_to_cart_button.dart';
import '../../../../features/shop/screens/product_detail/product_detail.dart';
import '../../../styles/shadows.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../icons/t_circular_icon.dart';
import '../../texts/product_price_text.dart';
import '../../texts/product_title_text.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    double getContainerHeight(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;

      if (screenHeight >= 867) {
        return 175.0;
      } else if (screenHeight >= 835) {
        return 166.0;
      } else if (screenHeight >= 732) {
        return 163.0;
      } else {
        return 155.0;
      }
    }

    double getContainerHeightForDiscount(BuildContext context) {
      final screenHeight = MediaQuery.of(context).size.height;

      if (screenHeight >= 867) {
        return 6;
      } else if (screenHeight >= 835) {
        return 6;
      } else if (screenHeight >= 732) {
        return 24;
      } else {
        return 34;
      }
    }

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(
            productId: product.packageId,
          )),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.white,
        ),
        child: Column(
          children: [
            ///Thumbnail, Discount, Tag
            TRoundedContainer(
              height: getContainerHeight(context),
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.grey,
              child: Stack(
                children: [
                  ///Thumbnail Image
                  TRoundedImage(
                    imageUrl: product.packageThumbnailUrl,
                    applyImageRadius: true,
                    borderRadius: 10,
                    isNetworkImage: true,
                  ),

                  /// Product Tag
                  Positioned(
                    bottom: getContainerHeightForDiscount(context),
                    left: 4,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),

                  /// -- Favourite Icon Button
                  const Positioned(
                    top: 2,
                    right: 2,
                    child: TCircularIcon(
                        icon: Iconsax.heart5,
                        color: Colors.red,
                        height: 35,
                        width: 35,
                        size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),

            ///Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: TSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(
                      title: product.packageName,
                      smallSize: true,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        Text(
                          'KGrill',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          width: TSizes.xs,
                        ),
                        const Icon(Iconsax.verify5,
                            color: TColors.primary, size: TSizes.iconXs),
                      ],
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Price
                          TProductPriceText(price: product.packagePrice),

                          ///Add to cart button
                          ProductCardAddToCartButton(product: product)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
