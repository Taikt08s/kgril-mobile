import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_ammount_section.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_input.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personalization/controller/user_profile_controller.dart';
import '../../controllers/check_out_controller.dart';
import '../../controllers/product/cart_controller.dart';
import '../cart/widgets/cart_items.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  String formatCurrency(double value) {
    final formatter = NumberFormat('#,##0');
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final UserProfileController userProfileController = Get.find<UserProfileController>();
    final CartController cartController = Get.find<CartController>();
    final CheckoutController checkoutController = Get.put(CheckoutController());
    final cartTotal = cartController.totalCartPrice;
    const double shippingFee = 50000;
    final double vat = cartTotal * 0.1;
    final double orderValue = cartTotal + shippingFee + vat;
    final double latitude = double.tryParse(userProfileController.latitude.text) ?? 0.0;
    final double longitude = double.tryParse(userProfileController.longitude.text) ?? 0.0;
    final int deliveryOrderId = int.tryParse(cartController.deliveryOrderId.value) ?? 0;
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Tổng quan đơn hàng',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Items in Cart
              const TCartItems(showAddRemoveButtons: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Coupon Textfield
              const TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Billing
              TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    TBillingAmountSection(
                      orderValue: cartTotal,
                      shippingFee: shippingFee,
                      vat: vat,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TBillingPaymentSection(
                      paymentMethod: 'Thanh toán khi nhận hàng',
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TBillingAddressSection(
                      recipientPhone: userProfileController.phone.text,
                      shippingAddress: userProfileController.address.text,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.mediumSpace),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              checkoutController.performCheckout(
                shippingAddress: userProfileController.address.text,
                latitude: latitude,
                longitude: longitude,
                deliveryOrderId: deliveryOrderId,
                orderValue: orderValue,
              );
            } ,
            child: Text('Thanh toán ₫${formatCurrency(orderValue)}'),
          ),
        ), // ElevatedButton
      ), // Padding
    );
  }
}
