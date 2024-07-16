import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/cart_controller.dart';
import '../../../controllers/product/product_detail_controller.dart';
import '../../../models/product_detail_model.dart';
import '../../../models/product_model.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({
    super.key,
    required this.product,
  });

  final ProductDetailController product;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final dark = THelperFunctions.isDarkMode(context);

    int packageId = product.productDetail.value.packageId;
    cartController.productQuantityInCart.value =
        cartController.getProductQuantityInCart(packageId);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.darkGrey,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  if (cartController.productQuantityInCart.value > 0) {
                    cartController.productQuantityInCart.value--;
                    cartController.updateQuantity(
                        packageId, cartController.productQuantityInCart.value);
                  }
                },
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Obx(() => Text(
                  cartController.productQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall)),
              const SizedBox(width: TSizes.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  cartController.productQuantityInCart.value++;
                  cartController.updateQuantity(
                      packageId, cartController.productQuantityInCart.value);
                },
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                final cartItem = cartController.convertDetailToCartItem(
                  product.productDetail.value,
                  cartController.productQuantityInCart.value,
                );
                cartController.addToCart(cartItem);
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: TColors.black,
                  side: const BorderSide(color: TColors.black)),
              child: const Text('Thêm vào giỏ hàng')),
        ],
      ),
    );
  }
}
