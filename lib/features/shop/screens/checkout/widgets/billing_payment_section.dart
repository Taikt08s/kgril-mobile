import 'package:flutter/material.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key, required this.paymentMethod});

  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TSectionHeading(title: 'Thanh toán', buttonTitle: 'Thay đổi', onPressed: () {}),
        const SizedBox(height: TSizes.spaceBtwItems / 2),
        Row(
          children: [
            TRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? TColors.light : TColors.white,
              padding: const EdgeInsets.all(TSizes.sm),
              child: const Image(image: AssetImage(TImages.cod), fit: BoxFit.contain),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Text(paymentMethod, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }
}

