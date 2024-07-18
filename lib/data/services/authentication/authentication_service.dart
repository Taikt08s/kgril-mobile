import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../utils/constants/connection_strings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jose/jose.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../shop/cart_service.dart';
import 'http_interceptor.dart';

class AuthenticationService {
  var client = HttpInterceptor();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final String? secretKey = dotenv.env['SECRET_KEY'];

  Future<void> saveTokenExpiration(DateTime expirationTime) async {
    final box = GetStorage();
    box.write('token_expiration', expirationTime.toIso8601String());
  }

  DateTime? getTokenExpiration() {
    final box = GetStorage();
    String? expirationString = box.read('token_expiration');
    if (expirationString != null) {
      return DateTime.parse(expirationString);
    }
    return null;
  }

  Future<void> monitorTokenExpiration() async {
    while (true) {
      await Future.delayed(const Duration(minutes: 1));
      DateTime? expirationTime = getTokenExpiration();
      if (expirationTime != null && DateTime.now().isAfter(expirationTime.subtract(const Duration(minutes: 1)))) {
        // Try to refresh token one minute before expiration
        var refreshToken = await secureStorage.read(key: 'refresh_token');
        var newTokens = await client.refreshTokens(refreshToken);
        if (newTokens == null) {
          // Logout if refresh fails
          await client.logoutUser();
          Get.off(() => const LoginScreen());
        } else {
          // Update expiration time
          var newExpirationTime = DateTime.now().add(const Duration(minutes: 30));
          await saveTokenExpiration(newExpirationTime);
        }
      }
    }
  }

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
        var expirationTime = DateTime.now().add(const Duration(minutes: 30));
        await saveTokenExpiration(expirationTime);
        monitorTokenExpiration();

        Get.put(() => CartService());

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
