import 'package:flutter/material.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng số tiền', style: Theme.of(context).textTheme.bodyMedium),
            Text('₫599,000', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        ///Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí ship', style: Theme.of(context).textTheme.bodyMedium),
            Text('₫40,000', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        ///Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Thuế VAT (10%)', style: Theme.of(context).textTheme.bodyMedium),
            Text('₫40,000', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        ///Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng thanh toán', style: Theme.of(context).textTheme.titleSmall),
            Text('₫679,000', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: TColors.primary)),
          ],
        ),
      ],
    );
  }
}
