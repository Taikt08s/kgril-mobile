import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../features/shop/models/check_out_model.dart';
import '../../../utils/constants/connection_strings.dart';

class CheckoutService {
  var client = http.Client();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<Map<String, Object>> checkout(CheckoutModel checkoutData) async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) {
      return {"success": false, "message": "No access token found"};
    }

    try {
      final response = await client.post(
        Uri.parse('${TConnectionStrings.deployment}delivery-order/check-out-order'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(checkoutData.toJson()),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Checkout successful');
        }
        return {"success": true, "message": "Checkout successful"};
      } else {
        if (kDebugMode) {
          print('Checkout failed: ${response.body}');
        }
        return {"success": false, "message": 'Checkout failed'};
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during checkout: $e');
      }
      return {"success": false, "message": 'Error during checkout: $e'};
    }
  }
}
