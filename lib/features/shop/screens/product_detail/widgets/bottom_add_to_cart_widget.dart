import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../controllers/product/cart_controller.dart';
import '../../../controllers/product/product_detail_controller.dart';

class TBottomAddToCart extends StatefulWidget {
  const TBottomAddToCart({
    super.key,
    required this.product,
  });

  final ProductDetailController product;

  @override
  TBottomAddToCartState createState() => TBottomAddToCartState();
}

class TBottomAddToCartState extends State<TBottomAddToCart> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final dark = THelperFunctions.isDarkMode(context);

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
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                  }
                },
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: TSizes.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.black,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                final productId = widget.product.productDetail.value.packageId;
                await cartController.addToCart(productId, quantity);
                TLoaders.customToast(message: 'Đã thêm vào giỏ hàng');
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
