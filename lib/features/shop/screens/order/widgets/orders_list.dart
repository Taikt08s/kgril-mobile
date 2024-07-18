import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../order_detail.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (_, index) =>
          const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, index) => TRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: dark ? TColors.dark : TColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // -- Row 1
            Row(
              children: [
                // 1 - Icon
                const Icon(Iconsax.receipt_item),
                const SizedBox(width: TSizes.spaceBtwItems / 2),

                // 2 - Status & Date
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đang xử lí',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.apply(color: TColors.primary, fontWeightDelta: 1),
                      ),
                      Text(
                        'Lẩu Manwah truyền thống',
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // 3 - Icon
                IconButton(
                    onPressed: () => Get.to(() => const OrderDetailScreen()),
                    icon:
                        const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm))
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems/2),

            // -- Row 2
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // 1 - Icon
                      const Icon(Iconsax.tag),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),

                      // 2 - Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Đơn hàng',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text('[#50394]',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 60,
                  child: VerticalDivider(
                    color: dark ? TColors.light : TColors.dark, // Match the dark mode
                    thickness: 1, // Appropriate thickness
                    width: 20, // Space between the columns
                  ),
                ),

                Expanded(
                  child: Row(
                    children: [
                      // 1 - Icon
                      const Icon(Iconsax.clock),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),

                      // 2 - Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ngày tạo đơn',
                                style: Theme.of(context).textTheme.labelMedium),
                            Text(
                              '08:21 07-11-2024',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
