import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kgrill_mobile/features/shop/controllers/product/cart_controller.dart';
import 'package:kgrill_mobile/features/shop/models/product_model.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/popups/loaders.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return GestureDetector(
      onTap: () async {
        final existingItem = cartController.cartItems
            .firstWhereOrNull((item) => item.packageId == product.packageId);
        if (existingItem == null) {
          await cartController.addToCart(product.packageId, 1);
          TLoaders.customToast(message: 'Đã thêm vào giỏ hàng');
        } else {
          await cartController.addToCart(
              product.packageId, existingItem.packageQuantity + 1);
        }
      },
      child: Obx(() {
        final item = cartController.cartItems
            .firstWhereOrNull((item) => item.packageId == product.packageId);
        final quantity = item?.packageQuantity ?? 0;
        return Container(
          decoration: BoxDecoration(
            color: quantity > 0 ? TColors.primary : TColors.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(TSizes.cardRadiusMd),
              bottomRight: Radius.circular(TSizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: TSizes.iconLg * 1.2,
            height: TSizes.iconLg * 1.2,
            child: Center(
              child: Center(
                child: quantity > 0
                    ? Text('$quantity',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: TColors.white))
                    : const Icon(Iconsax.add, color: TColors.white),
              ),
            ),
          ),
        );
      }),
    );
  }
}