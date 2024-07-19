import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgrill_mobile/common/widgets/loaders/animation_loader.dart';
import 'package:kgrill_mobile/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:kgrill_mobile/navigation_dart.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/product/cart_controller.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    cartController.fetchCart();
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Giỏ hàng',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(
        () {
          final emptyWidget = TAnimationLoaderWidget(
              text: 'Giỏ hàng trống trơn',
              animation: TImages.screenLoadingAcheron,
              showAction: true,
              actionText: 'Tiếp tục lựa chọn',
              onActionPressed: () => Get.off(() => const NavigationMenu()));

          if (cartController.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: TCartItems(),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Obx(() {
        final isOverLimit =
            cartController.totalCartPrice > CartController.maxTotalPrice;
        return cartController.cartItems.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: SizedBox(
                  height: 70,
                  child: ElevatedButton(
                    onPressed: isOverLimit
                        ? null
                        : () => Get.to(() => const CheckoutScreen()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(isOverLimit
                            ? 'Giỏ hàng không thể vượt quá 5 triệu VND'
                            : 'Thanh toán ${cartController.formatPrice(cartController.totalCartPrice)}'),
                        const SizedBox(height: TSizes.smallSpace / 2),
                        const Text(
                          '(đã bao gồm thuế GTGT)',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
