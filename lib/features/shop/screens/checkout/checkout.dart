import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_ammount_section.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/cart/coupon_input.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../navigation_dart.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../cart/widgets/cart_items.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Tổng quan đơn hàng',
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
                child:  const Column(
                  children: [
                    TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

                    TBillingAddressSection(),
                    SizedBox(height: TSizes.spaceBtwItems),

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
            onPressed: () => Get.to(
                  () => SuccessScreen(
                image: TImages.screenLoadingRobin,
                title: 'Đặt hàng thành công!',
                subTitle: 'Chúng tôi đã tiếp nhận đơn và sẽ vận chuyển sớm nhất có thể vui lòng theo dõi trạng thái đơn hàng',
                onPressed: () => Get.offAll(() => const NavigationMenu()),
              ),
            ),
            child: const Text('Thanh toán ₫679,000'),
          ),
        ), // ElevatedButton
      ), // Padding

    );
  }
}

