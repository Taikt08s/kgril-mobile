import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../features/shop/models/product_model.dart';
import '../../../utils/constants/connection_strings.dart';

class ProductService {
  var client = http.Client();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<List<ProductModel>> fetchProductData() async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) {
      throw Exception("No access token found");
    }

    try {
      var response = await client.post(
        Uri.parse('${TConnectionStrings.deployment}mobile/food-package/search'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        if (kDebugMode) {
          print('Successfully retrieved product data: $data');
        }
        final List<dynamic> productsJson = data['data'];
        return productsJson.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        if (kDebugMode) {
          print('Failed to retrieve product data: ${response.body}');
        }
        throw Exception('Failed to retrieve product data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving product data: $e');
      }
      throw Exception('Error retrieving product data: $e');
    }
  }

  Future<List<ProductModel>> fetchProductsByType(String type) async {
    List<ProductModel> products = await fetchProductData();
    return products.where((product) => product.packageType == type).toList();
  }
}
