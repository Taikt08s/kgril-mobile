import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgrill_mobile/features/shop/screens/cart/widgets/cart_items.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Giỏ hàng',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: const TCartItems(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SizedBox(
            height: 60,
            child: ElevatedButton(
                onPressed: () => Get.to(()=>const CheckoutScreen()), child: const Text('Thanh toán ₫599,000'))),
      ),
    );
  }
}
