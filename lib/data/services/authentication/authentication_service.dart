import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constants/connection_strings.dart';

class AuthenticationService {
  var client = http.Client();

  Future<Map<String, dynamic>> handleSignUp({
    required String email,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
    required String password,
  }) async {
    var userRegisterInformation = {
      "email": email.trim(),
      "address": address.trim(),
      "phone": phone.trim(),
      "password": password.trim(),
      "first_name": firstName.trim(),
      "last_name": lastName.trim()
    };

    try {
      var response = await client
          .post(Uri.parse('${TConnectionStrings.deployment}auth/register'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(userRegisterInformation))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 202) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          print('Successful Register: $data');
        }
        return {"success": true, "data": data};
      } else if (response.statusCode == 409) {
        if (kDebugMode) {
          print('Register failed: ${response.body}');
        }
        return {
          "success": false,
          "message":
              'Tài khoản này đã được đăng kí với email này vui lòng kiểm tra lại'
        };
      } else {
        return {
          "success": false,
          "message": 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau'
        };
      }
    } catch (e) {
      return {"success": false, "message": 'Đã xảy ra sự cố: $e'};
    }
  }

  Future<dynamic> handleSignIn({
    required String email,
    required String password,
  }) async {
    var userSignInInformation = {
      "email": email.trim(),
      "password": password.trim(),
    };

    var response = await client.post(
      Uri.parse('${TConnectionStrings.deployment}auth/singin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userSignInInformation),
    );

    return response;
  }
}
