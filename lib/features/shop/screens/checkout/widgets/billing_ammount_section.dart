import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection(
      {super.key,
      required this.orderValue,
      required this.shippingFee,
      required this.vat});

  final double orderValue;
  final double shippingFee;
  final double vat;

  String formatCurrency(double value) {
    final formatter = NumberFormat('#,##0');
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = (orderValue + shippingFee + vat);
    return Column(
      children: [
        ///Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng số tiền', style: Theme.of(context).textTheme.bodyMedium),
            Text('₫${formatCurrency(orderValue)}',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        ///Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí ship', style: Theme.of(context).textTheme.bodyMedium),
            Text('₫${formatCurrency(shippingFee)}',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        ///Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Thuế VAT (10%)',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('₫${formatCurrency(vat)}',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        ///Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng thanh toán',
                style: Theme.of(context).textTheme.titleSmall),
            Text('₫${formatCurrency(totalAmount)}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: TColors.primary)),
          ],
        ),
      ],
    );
  }
}
