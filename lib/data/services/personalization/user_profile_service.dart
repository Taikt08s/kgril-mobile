import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constants/connection_strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProfileService {
  var client = http.Client();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) {
      return {"success": false, "message": "No access token found"};
    }

    try {
      var response = await client.get(
        Uri.parse('${TConnectionStrings.deployment}account/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('Successfully retrieved user information: $data');
        }
        return {"success": true, "data": data};
      } else {
        if (kDebugMode) {
          print('Failed to retrieve user information: ${response.body}');
        }
        return {
          "success": false,
          "message": 'Failed to retrieve user information',
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving user information: $e');
      }
      return {"success": false, "message": 'Error retrieving user information: $e'};
    }
  }
}