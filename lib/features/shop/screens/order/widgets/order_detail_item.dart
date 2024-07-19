import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kgrill_mobile/features/shop/models/order_model.dart';

import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TOrderDetailItem extends StatelessWidget {
  const TOrderDetailItem({
    super.key,
    required this.orderDetail,
  });

  final OrderDetailModel orderDetail;

  String formatCurrency(double value) {
    final formatter = NumberFormat('#,##0');
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TRoundedImage(
          imageUrl: orderDetail.packageThumbnailUrl,
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(TSizes.xs / 2),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),

        const SizedBox(width: TSizes.spaceBtwItems),

        /// Title, Price
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orderDetail.packageName,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),

              /// Quantity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Số lượng: ',
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                            text: orderDetail.packageQuantity.toString(),
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Giá: ',
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                            text: '${formatCurrency(orderDetail.packagePrice)}₫',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
