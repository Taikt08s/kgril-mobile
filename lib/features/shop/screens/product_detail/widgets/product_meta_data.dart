import 'package:flutter/material.dart';
import 'package:kgrill_mobile/common/widgets/images/t_circular_image.dart';
import 'package:kgrill_mobile/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';
import 'package:kgrill_mobile/utils/constants/enums.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_detail_model.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key, required this.product,
  });
  final ProductDetailModel product;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text('25%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black)),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            /// Price
            Text('₫627,000',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: TSizes.spaceBtwItems),
             TProductPriceText(price: product.packagePrice, isLarge: true),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
         TProductTitleText(
            title: product.packageName),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Number of people
         Row(
          children: [
            const TProductTitleText(title: 'Combo dành cho',smallSize: true),
            const SizedBox(width: TSizes.spaceBtwItems /2),
            TProductTitleText(title: product.packageSize),

          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Brand
        Row(
          children: [
            TCircularImage(
              image: TImages.lightAppLogo,
              height: 35,
              width: 35,
              overlayColor: darkMode ? TColors.white : TColors.black,
            ),
            const TBrandTitleWithVerifiedIcon(
              title: ' KGrill',
              brandTextSize: TextSizes.large,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
      ],
    );
  }
}
