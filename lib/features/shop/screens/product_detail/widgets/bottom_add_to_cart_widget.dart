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
  bool hasShownToast = false;
  late CartController cartController;

  @override
  void initState() {
    super.initState();
    cartController = Get.put(CartController());
    final productInCart = cartController.cartItems
        .firstWhereOrNull((item) => item.packageId == widget.product.productDetail.value.packageId);
    if (productInCart != null) {
      quantity = productInCart.packageQuantity;
    }
  }

  bool canAddToCart(double productPrice) {
    final newTotalPrice = cartController.totalCartPrice + (quantity * productPrice);
    if (newTotalPrice > CartController.maxTotalPrice) {
      if (!hasShownToast) {
        hasShownToast = true;
        TLoaders.customToast(message: 'Tổng giá trị giỏ hàng không thể vượt quá 5 triệu VND. Vui lòng kiểm tra giỏ hàng');
        Future.delayed(const Duration(seconds: 2), () {
          hasShownToast = false;
        });
      }
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final productPrice = widget.product.productDetail.value.packagePrice;

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
                  if (canAddToCart(productPrice)) {
                    setState(() {
                      quantity++;
                    });
                  }
                },
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                final productId = widget.product.productDetail.value.packageId;
                if (canAddToCart(productPrice)) {
                  await cartController.addToCart(productId, quantity);
                  TLoaders.customToast(message: 'Đã thêm vào giỏ hàng');
                }
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
