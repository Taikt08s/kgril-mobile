import 'package:flutter/material.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_ammount_section.dart';
import 'package:kgrill_mobile/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../cart/widgets/cart_items.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
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
              const TCartItems(showAddRemoveButtons: false),
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
    );
  }
}

