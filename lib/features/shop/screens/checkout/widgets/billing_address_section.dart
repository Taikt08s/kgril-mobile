import 'package:flutter/material.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection(
      {super.key, required this.recipientPhone, required this.shippingAddress});

  final String recipientPhone;
  final String shippingAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
            title: 'Địa chỉ nhận hàng ',
            buttonTitle: 'Thay đổi',
            onPressed: () {}),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(recipientPhone, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: Text(shippingAddress,
                  style: Theme.of(context).textTheme.bodyMedium,
                  softWrap: true),
            ),
          ],
        ),
      ],
    );
  }
}
