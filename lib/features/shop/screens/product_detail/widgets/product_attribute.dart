import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';
import 'package:kgrill_mobile/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';
import 'package:kgrill_mobile/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_detail_model.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductDetailModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// --- Checkout
        SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed: () {}, child: const Text('Mua ngay'))),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// --- Selected Attribute Pricing & Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TSectionHeading(
                      title: 'Gồm có ', showActionButton: false),

                  ///Dish Component
                  TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Dish Component
                            ...product.dishes.map((dish) => Row(
                                  children: [
                                    /// Dish Name
                                    Text(
                                      '+ ${dish.dishName}',
                                    ),
                                    const SizedBox(width: TSizes.smallSpace),

                                    /// Quantity
                                    Text(
                                      'x${dish.dishQuantity}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /// Description
        const SizedBox(height: TSizes.spaceBtwItems),
        const TSectionHeading(title: 'Mô tả', showActionButton: false),
        const SizedBox(height: TSizes.spaceBtwItems),
        ReadMoreText(product.packageDescription,
            trimLines: 4,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' mở rộng',
            trimExpandedText: ' thu gọn',
            moreStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            lessStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),

        /// Reviews
        const SizedBox(height: TSizes.spaceBtwItems),
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TSectionHeading(
                title: 'Đánh giá (69)', showActionButton: false),
            IconButton(
              onPressed: ()=> Get.to(()=> const ProductReviewsScreen()),
              icon: const Icon(
                Iconsax.arrow_right_3,
                size: 18,
              ),
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
      ],
    );
  }
}
