import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kgrill_mobile/utils/popups/loaders.dart';

import '../../../../data/services/shop/cart_service.dart';
import '../../models/cart_item_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItemModel>[].obs;
  var isLoading = true.obs;
  final CartService _cartService = CartService();

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    isLoading.value = true;
    await _cartService.fetchCart();
    cartItems.value = _cartService.cartItems;
    isLoading.value = false;
  }

  Future<void> addToCart(int packageId, int quantity) async {
    await _cartService.addToCart(packageId, quantity);
    cartItems.value = _cartService.cartItems;
  }

  Future<void> updateCartItemQuantity(int orderDetailId, int quantity) async {
    await _cartService.updateCartItemQuantity(orderDetailId, quantity);
    cartItems.value = _cartService.cartItems;
  }

  double get totalCartPrice {
    return cartItems.fold(
        0, (sum, item) => sum + item.packagePrice * item.packageQuantity);
  }

  String formatPrice(double price) {
    final NumberFormat formatter = NumberFormat("#,###");
    return '${formatter.format(price)}₫';
  }

  int get totalCartQuantity {
    return cartItems.fold(0, (sum, item) => sum + item.packageQuantity);
  }

  void removeFromCartDialog(int orderDetailId) {
    Get.defaultDialog(
      title: 'Xóa khỏi giỏ hàng?',
      middleText: 'Bạn chắc rằng mình muốn xóa sản phẩm này khỏi giỏ hàng chứ?',
      onConfirm: () async {
        await updateCartItemQuantity(orderDetailId, 0);
        TLoaders.customToast(message: 'Đã xóa khỏi giỏ hàng');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }
}
