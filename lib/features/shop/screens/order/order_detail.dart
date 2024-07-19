import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_ammount_section.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:kgrill_mobile/features/shop/screens/order/widgets/order_detail_item.dart';
import 'package:kgrill_mobile/features/shop/screens/order/widgets/order_status.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final vat = order.orderValue * 0.1;

    final statusSteps = [
      {
        'title': 'Đang xử lí',
        'subtitle': 'Chúng tôi đã nhận được đơn và đang xử lí',
        'icon': Iconsax.activity,
        'status': 'Ordering',
      },
      {
        'title': 'Đang chuẩn bị',
        'subtitle': 'Đơn hàng đang được chuẩn bị bởi nhà bếp',
        'icon': Iconsax.box,
        'status': 'Preparing',
      },
      {
        'title': 'Shipper đang giao',
        'subtitle': 'Shipper đang giao hàng đến bạn',
        'icon': Iconsax.truck,
        'status': 'Delivering',
      },
    ];

    final currentStatus = order.orderStatus;

    Color getStatusColor(String status, String currentStatus) {
      if (status == currentStatus) {
        if (status == 'Delivering') return Colors.orange;
        if (status == 'Cancelled') return TColors.error;
        return TColors.primary;
      } else if (status == 'Delivered' || status == 'Cancelled') {
        return Colors.black26;
      }
      return TColors.primary;
    }

    bool isActive(String status, String currentStatus) {
      if (status == currentStatus) return true;
      final statusOrder = ['Ordering', 'Processing', 'Preparing', 'Delivering', 'Delivered', 'Cancelled'];
      return statusOrder.indexOf(status) <= statusOrder.indexOf(currentStatus);
    }

    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Chi tiết đơn hàng',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall)),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.orderDetail.length,
                separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
                itemBuilder: (_, index) {
                  final orderDetail = order.orderDetail[index];
                  return TOrderDetailItem(orderDetail: orderDetail);
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Order status Tracking
              Column(
                children: [
                  ...statusSteps.map((step) {
                    final status = step['status'] as String;
                    return OrderStatusStep(
                      title: step['title'] as String,
                      subtitle: step['subtitle'] as String,
                      icon: step['icon'] as IconData,
                      iconColor: getStatusColor(status, currentStatus),
                      isActive: isActive(status, currentStatus),
                      isLast: false,
                    );
                  }),
                  if (currentStatus == 'Delivered' || currentStatus == 'Cancelled')
                    OrderStatusStep(
                      title: currentStatus == 'Delivered' ? 'Đã giao đơn' : 'Đã hủy đơn',
                      subtitle: currentStatus == 'Delivered'
                          ? 'Đơn đã được giao đến bạn'
                          : 'Đơn đã bị hủy bỏ',
                      icon: currentStatus == 'Delivered' ? Iconsax.tick_circle : Iconsax.close_circle,
                      iconColor: currentStatus == 'Delivered' ? TColors.success : TColors.error,
                      isLast: true,
                      isActive: true,
                    ),
                  if (currentStatus != 'Delivered' && currentStatus != 'Cancelled')
                    const OrderStatusStep(
                      title: 'Đã giao đơn',
                      subtitle: 'Đơn đã được giao đến bạn',
                      icon: Iconsax.tick_circle,
                      iconColor: Colors.black26,
                      isLast: true,
                      isActive: false,
                    ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Billing
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child:   Column(
                  children: [
                    TBillingAmountSection(orderValue: order.orderValue,
                      shippingFee: order.shippingFee,
                      vat: vat),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),

                     TBillingPaymentSection(paymentMethod: order.orderPaymentMethod),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TBillingAddressSection(recipientPhone: order.orderContactPhone, shippingAddress: order.shippedAddress,),
                    const SizedBox(height: TSizes.spaceBtwItems),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

