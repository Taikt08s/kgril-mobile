import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../../navigation_dart.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/order_controller.dart';
import '../order_detail.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final OrderController orderController = Get.put(OrderController());
    return Obx(() {
      final emptyOrderWidget = TAnimationLoaderWidget(
          text: 'Bạn chưa tạo đơn hàng nào cả',
          animation: TImages.screenLoadingAcheron,
          showAction: true,
          actionText: 'Tiếp tục lựa chọn',
          onActionPressed: () => Get.off(() => const NavigationMenu()));

      if (orderController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (orderController.orders.isEmpty) {
        return emptyOrderWidget;
      }

      return ListView.separated(
        shrinkWrap: true,
        itemCount: orderController.orders.length,
        separatorBuilder: (_, index) =>
        const SizedBox(height: TSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          final order = orderController.orders[index];
          return TRoundedContainer(
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
                            order.orderStatus,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.apply(color: TColors.primary, fontWeightDelta: 1),
                          ),
                          Text(
                            order.orderDetail.map((e) => e.packageName).join(', '),
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // 3 - Icon
                    IconButton(
                        onPressed: () => Get.to(() => OrderDetailScreen(order: order)),
                        icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm))
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                // -- Row 2
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          // 1 - Icon
                          const Icon(Iconsax.tag),
                          const SizedBox(width: TSizes.spaceBtwItems / 2),

                          // 2 - Order ID & Total
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Đơn hàng',
                                    style: Theme.of(context).textTheme.labelMedium),
                                Text('#${order.orderCode}',
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

                          // 2 - Order Date & Time
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ngày tạo đơn',
                                    style: Theme.of(context).textTheme.labelMedium),
                                Text(
                                  DateFormat('HH:mm dd-MM-yyyy').format(order.orderDate),
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
          );
        },
      );
    });
  }
}