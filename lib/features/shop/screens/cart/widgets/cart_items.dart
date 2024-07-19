import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/cart_controller.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: TSizes.spaceBtwSections),
        itemBuilder: (_, index) {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              TCartItem(cartItem: item),
              if (showAddRemoveButtons)
                const SizedBox(height: TSizes.spaceBtwItems),
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        TProductQuantityWithAddAndRemoveButton(
                          quantity: item.packageQuantity,
                          add: () async {
                            await cartController.updateCartItemQuantity(
                                item.orderDetailId, item.packageQuantity + 1);
                          },
                          remove: () async {
                            if (item.packageQuantity > 1) {
                              await cartController.updateCartItemQuantity(item.orderDetailId, item.packageQuantity - 1);
                            } else {
                              cartController.removeFromCartDialog(item.orderDetailId);
                            }
                          },
                        ),
                      ],
                    ),
                    TProductPriceText(
                        price: (item.packagePrice * item.packageQuantity)),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
