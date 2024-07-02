import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/connection_strings.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/login/login.dart';

class LogoutController extends GetxController {
  var client = http.Client();
  final storage = const FlutterSecureStorage();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> logout() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog(
          'Đang xử lí chờ xíu...', TImages.screenLoadingSparkle3);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Retrieve the refresh token from secure storage
      final refreshToken = await storage.read(key: 'refresh_token');

      // Make the logout request
      var response = await client.post(
        Uri.parse('${TConnectionStrings.deployment}auth/logout'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $refreshToken',
        },
      ).timeout(const Duration(seconds: 10));

      TFullScreenLoader.stopLoading();
      if (response.statusCode == 200) {
        await storage.delete(key: 'access_token');
        await storage.delete(key: 'refresh_token');
        await googleSignIn.signOut();

        TLoaders.successSnackBar(
            title: 'Đăng xuất thành công',
            message: 'Bạn đã đăng xuất thành công');
        Get.offAll(() => const LoginScreen());
      } else if (response.statusCode == 401) {
        TLoaders.errorSnackBar(
            title: 'Đăng xuất thất bại',
            message: 'Đã xảy ra lỗi không xác định');
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print('Error occurred: $e');
      }
      TLoaders.errorSnackBar(
          title: 'Đăng xuất thất bại',
          message: 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau');
    }
  }
}