import 'package:flutter/material.dart';
import 'package:kgrill_mobile/features/shop/models/cart_item_model.dart';
import '../../../../common/widgets/texts/t_brand_title_text_with_verifed_icon.dart';
import 'package:kgrill_mobile/features/shop/screens/product_detail/widgets/product_title.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../images/t_rounded_image.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: cartItem.packageThumbnailUrl,
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(TSizes.xs / 2),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),

        const SizedBox(width: TSizes.spaceBtwItems),

        ///Title, Price
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBrandTitleWithVerifiedIcon(title: 'KGrill'),
              Flexible(
                  child: TProductTitleText(
                      title: cartItem.packageName, maxLines: 1)),

              ///Attribute
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Cho ',
                        style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(
                        text: cartItem.packageType,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
