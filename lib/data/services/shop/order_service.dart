import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../features/shop/models/order_model.dart';
import '../../../utils/constants/connection_strings.dart';
import '../personalization/user_profile_service.dart';

class OrderService extends GetxService {
  var client = http.Client();
  var orders = <OrderModel>[].obs;
  final UserProfileService _userProfileService = UserProfileService();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<void> fetchOrderHistory() async {
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
        Uri.parse('${TConnectionStrings.deployment}delivery-order/order-history?userId=$userId'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data['data'] != null) {
          orders.value = (data['data'] as List).map((item) => OrderModel.fromJson(item)).toList();
        } else {
          orders.value = [];
        }
      } else {
        orders.value = [];
        throw Exception('Failed to load order history');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching order history: $e');
      }
    }
  }
}
