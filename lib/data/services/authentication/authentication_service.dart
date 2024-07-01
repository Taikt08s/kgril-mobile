import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constants/connection_strings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jose/jose.dart';

class AuthenticationService {
  var client = http.Client();

  final String? secretKey = dotenv.env['SECRET_KEY'];

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

  static Future<Map<String, dynamic>> decryptJweToken(String encryptedToken) async {
    final secretKey = dotenv.env['SECRET_KEY']!;
    final keyStore = JsonWebKeyStore()
      ..addKey(JsonWebKey.fromJson({
        "kty": "oct",
        "k": base64Url.encode(base64Decode(secretKey))
      }));
    final jwe = JsonWebEncryption.fromCompactSerialization(encryptedToken);
    final payload = await jwe.getPayload(keyStore);

    return jsonDecode(payload.stringContent);
  }

  Future<dynamic> handleSignIn({
    required String email,
    required String password,
  }) async {
    var userSignInInformation = {
      "email": email.trim().toLowerCase(),
      "password": password.trim(),
    };
    try {
      var response = await client
          .post(Uri.parse('${TConnectionStrings.deployment}auth/signin'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(userSignInInformation))
          .timeout(const Duration(seconds: 10));

      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Successful Login: $responseData');
        }
        return {"success": true, "data": responseData};
      } else if (response.statusCode == 401) {
        if (responseData['message'] == 'Email or Password is incorrect') {
          if (kDebugMode) {
            print('Login failed: ${response.body}');
          }
          return {"success": false, "data": responseData};
        } else if (responseData['message'] ==
            'Account is disabled please contact administrator for more information') {
          if (kDebugMode) {
            print('Login failed: ${response.body}');
          }
          return {"accountDisabled": true, "data": responseData};
        } else if (responseData['message'] ==
            'Account is locked please contact administrator for more information') {
          if (kDebugMode) {
            print('Login failed: ${response.body}');
          }
          return {"accountLocked": true, "data": responseData};
        } else {
          return {
            "loginFailed": true,
            "message": 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau'
          };
        }
      }
    } catch (e) {
      return {"loginFailed": false, "message": 'Đã xảy ra sự cố: $e'};
    }
  }
}
