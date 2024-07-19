import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../features/shop/models/cart_item_model.dart';
import '../../../utils/constants/connection_strings.dart';
import '../personalization/user_profile_service.dart';

class CartService {
  var client = http.Client();
  var cartItems = <CartItemModel>[].obs;
  var orderId = ''.obs;
  final UserProfileService _userProfileService = UserProfileService();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<void> fetchCart() async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception("No access token found");
    }

    String? userId = await _userProfileService.getUserId();
    if (userId == null) {
      throw Exception("Failed to get user profile");
    }

    try {
      final response = await http.get(
        Uri.parse('${TConnectionStrings.deployment}delivery-order/cart-detail?userId=$userId'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

        if (data['data'] != null && data['data']['order_id'] != null) {
          orderId.value = data['data']['order_id'].toString();
          if (data['data']['order_detail_list'] != null && data['data']['order_detail_list'].isNotEmpty) {
            cartItems.value = (data['data']['order_detail_list'] as List)
                .map((item) => CartItemModel.fromJson(item))
                .toList();
          } else {
            cartItems.value = [];
          }
        } else {
          cartItems.value = [];
        }
      } else {
        cartItems.value = [];
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching cart: $e');
      }
    }
  }

  Future<void> addToCart(int packageId, int quantity) async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception("No access token found");
    }

    String? userId = await _userProfileService.getUserId();
    if (userId == null) {
      throw Exception("Failed to get user profile");
    }

    try {
      final response = await http.post(
        Uri.parse('${TConnectionStrings.deployment}delivery-order/add-package?userId=$userId&packageId=$packageId&quantity=$quantity'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        await fetchCart();
      } else {
        throw Exception('Failed to add to cart');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding to cart: $e');
      }
    }
  }

  Future<void> updateCartItemQuantity(int orderDetailId, int quantity) async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception("No access token found");
    }

    try {
      final response = await http.post(
        Uri.parse('${TConnectionStrings.deployment}delivery-order/update-order-detail?orderDetailId=$orderDetailId&quantity=$quantity'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        await fetchCart();
      } else {
        throw Exception('Failed to update cart');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating cart: $e');
      }
    }
  }
}