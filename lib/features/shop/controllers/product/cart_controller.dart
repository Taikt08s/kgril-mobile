import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kgrill_mobile/utils/local_storage/storage_utility.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_detail_model.dart';
import '../../models/product_model.dart';

class CartController extends GetxController {
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  var cartItems = <CartItemModel>[].obs;
  final TLocalStorage _storage = TLocalStorage.instance();

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    final savedCart = _storage.readData<List<dynamic>>('cart');
    if (savedCart != null) {
      cartItems.value =
          savedCart.map((item) => CartItemModel.fromJson(item)).toList();
    }
    updateCartTotals();
  }

  void addToCart(CartItemModel cartItem) {
    // if (productQuantityInCart.value < 1) {
    //   TLoaders.customToast(message: 'Select Quantity');
    //   return;
    // }

    int index =
        cartItems.indexWhere((item) => item.packageId == cartItem.packageId);
    if (index >= 0) {
      cartItems[index].quantity += cartItem.quantity;
    } else {
      cartItems.add(cartItem);
    }
    _storage.writeData('cart', cartItems.map((item) => item.toJson()).toList());
    updateCart();
  }

  void updateQuantity(int packageId, int quantity) {
    int index = cartItems.indexWhere((item) => item.packageId == packageId);
    if (index >= 0) {
      cartItems[index].quantity = quantity;
    }
    updateCart();
  }

  void addToCartWithDefaultQuantity(CartItemModel cartItem) {
    final updatedItem = CartItemModel(
      packageId: cartItem.packageId,
      packageName: cartItem.packageName,
      packagePrice: cartItem.packagePrice,
      quantity: 1,
      packageThumbnailUrl: cartItem.packageThumbnailUrl,
      packageType: cartItem.packageType,
    );
    addToCart(updatedItem);
  }

  void removeFromCart(CartItemModel cartItem) {
    int index =
        cartItems.indexWhere((item) => item.packageId == cartItem.packageId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        Get.defaultDialog(
          title: 'Xóa Sản Phẩm',
          middleText: "Bạn có chắc muốn xóa sản phẩm này ra khỏi giỏ hàng không?",
          confirm: ElevatedButton(
              onPressed: () {
                cartItems.removeAt(index);
                _storage.writeData(
                    'cart', cartItems.map((item) => item.toJson()).toList());
                updateCart();
                TLoaders.customToast(message: "Đã xóa sản phẩm khỏi giỏ hàng");
                Get.back();
              },
              child: const Text('Xác nhận')),
          cancel: ElevatedButton(
              onPressed: () => Get.back(), child: const Text('Hủy')),
        );
      }
      _storage.writeData(
          'cart', cartItems.map((item) => item.toJson()).toList());
      updateCart();
    }
  }

  void clearCart() {
    cartItems.clear();
    _storage.writeData('cart', []);
  }

  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    return CartItemModel(
      packageId: product.packageId,
      packageName: product.packageName,
      packagePrice: product.packagePrice,
      quantity: quantity,
      packageThumbnailUrl: product.packageThumbnailUrl,
      packageType: product.packageType,
    );
  }


  void updateCart() {
    cartItems.refresh();
    saveCartItems();
    updateCartTotals();
  }

  void updateCartTotals() {
    double calculatedTotalPrices = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrices += (item.packagePrice) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }
    // Update observable values
    totalCartPrice.value = calculatedTotalPrices;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    _storage.writeData('cartItems', cartItemStrings);
  }

  String formatPrice(double price) {
    final NumberFormat formatter = NumberFormat("#,###");
    return '${formatter.format(price)}₫'; // Prefix with ₫ symbol
  }

  int totalQuantity() {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  int getProductQuantityInCart(int packageId) {
    return cartItems.where((item) => item.packageId == packageId).fold(0, (previousValue, element) => previousValue + element.quantity);
  }

  CartItemModel convertDetailToCartItem(ProductDetailModel detail, int quantity) {
    return CartItemModel(
      packageId: detail.packageId,
      packageName: detail.packageName,
      packagePrice: detail.packagePrice,
      quantity: quantity,
      packageThumbnailUrl: detail.packageThumbnailUrl,
      packageType: detail.packageType,
    );
  }
}
