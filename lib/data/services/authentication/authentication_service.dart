import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../utils/constants/connection_strings.dart';
import '../../../utils/popups/loaders.dart';

class AuthenticationService {
  var client = http.Client();

  Future<void> handleSignUp({
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

    var response = await client
        .post(
          Uri.parse('${TConnectionStrings.deployment}auth/register'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(userRegisterInformation),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 202) {
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print('Successful Register: $data');
      }
      TLoaders.successSnackBar(
          title: 'Thành công!', message: 'Đăng ký thành công.');
      Get.to(() => const VerifyEmailScreen());
      return;
    } else {
      if (kDebugMode) {
        print('Login failed: ${response.body}');
      }
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
