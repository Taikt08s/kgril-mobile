import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/constants/connection_strings.dart';
import '../../../navigation_dart.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> handleGoogleSignIn(BuildContext context) async {
  const secureStorage = FlutterSecureStorage();

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  try {
    TFullScreenLoader.openLoadingDialog(
        'Đang xử lí chờ xíu...', TImages.screenLoadingSparkle1);

    //check internet connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      TFullScreenLoader.stopLoading();
      return;
    }
    final names = googleUser.displayName?.split(' ') ?? [''];
    final firstName = names.first;
    final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

    final userInfo = {
      'first_name': firstName,
      'last_name': lastName,
      'email': googleUser.email,
      'id': googleUser.id,
      'photo_url': googleUser.photoUrl,
    };

    // Send user information to the backend
    final response = await http
        .post(
          Uri.parse('${TConnectionStrings.deployment}auth/google-signin'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(userInfo),
        )
        .timeout(const Duration(seconds: 10));

    TFullScreenLoader.stopLoading();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data['data']?['access_token'];
      final refreshToken = data['data']?['refresh_token'];
      await secureStorage.write(key: 'access_token', value: accessToken);
      await secureStorage.write(key: 'refresh_token', value: refreshToken);

      TLoaders.successSnackBar(
          title: 'Chào mừng quay trở lại!',
          message: 'Rất nhiều ưu đãi đang chờ đón bạn');
      Get.off(() => const NavigationMenu());
      if (kDebugMode) {
        print('Login successful: $data');
      }
    } else {
      TLoaders.errorSnackBar(
          title: 'Xảy ra lỗi rồi!',
          message: 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau');
      if (kDebugMode) {
        print('Login failed: ${response.body}');
      }
    }
  } catch (e) {
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(
        title: 'Xảy ra lỗi rồi!',
        message: 'Vui lòng kiểm tra lại kết nối mạng + $e');
    if (kDebugMode) {
      print(e);
    }
  }
}

///This method use to logged out the user who sign in with the google account
// Future<void> handleGoogleSignOut(BuildContext context) async {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//
//   try {
//     await googleSignIn.signOut();
//   } catch (e) {
//     if (kDebugMode) {
//       print(e);
//     }
//   }
// }
