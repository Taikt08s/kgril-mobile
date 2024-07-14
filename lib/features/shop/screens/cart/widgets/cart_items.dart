import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 4,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) => Column(
          children: [
            const TCartItem(),
            if (showAddRemoveButtons)
              const SizedBox(height: TSizes.spaceBtwItems),
            if (showAddRemoveButtons)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 70),

                      ///Add remove button
                      TProductQuantityWithAddAndRemoveButton(),
                    ],
                  ),
                  // TProductPriceText(price: '599,000'),
                ],
              )
          ],
        ),
      ),
    );
  }
}
