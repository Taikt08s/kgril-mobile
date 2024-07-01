import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/services/authentication/authentication_service.dart';
import '../../../../navigation_dart.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends GetxController {
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final secureStorage = const FlutterSecureStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordSignIn() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog(
          'Đang xử lí chờ xíu...', TImages.screenLoadingSparkle2);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final result = await AuthenticationService().handleSignIn(
        email: email.text,
        password: password.text,
      );

      TFullScreenLoader.stopLoading();

      if (result['success'] == true) {
        final accessToken = result['data']?['data']?['access_token'];
        final refreshToken = result['data']?['data']?['refresh_token'];

        // Store tokens securely
        await secureStorage.write(key: 'access_token', value: accessToken);
        await secureStorage.write(key: 'refresh_token', value: refreshToken);

        // Decode the JWT to check the user role
        // Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
        Map<String, dynamic> decodedToken = await AuthenticationService.decryptJweToken(accessToken);
        String? userRole = decodedToken['role'];

        // Navigate based on user role
        if (userRole == 'USER') {
          TLoaders.successSnackBar(
              title: 'Chào mừng quay trở lại!',
              message: 'Rất nhiều ưu đãi đang chờ đón bạn');
          Get.to(() => const NavigationMenu());
        }
      } else if (result['success'] == false) {
        TLoaders.warningSnackBar(
          title: 'Xác thực không thành công',
          message: ' Email/Mật khẩu không chính xác',
        );
      } else if (result['accountDisabled'] == true) {
        TLoaders.warningSnackBar(
          title: 'Tài khoản chưa xác thực',
          message: 'Vui lòng kiểm tra lại email và xác thực tài khoản',
        );
      } else if (result['accountLocked'] == true) {
        TLoaders.warningSnackBar(
          title: 'Tài khoản bị vô hiệu hóa',
          message: 'Tài khoản của bạn đã bị vô hiệu hóa vui lòng liên hệ CSKH',
        );
      } else if (result['loginFailed'] == true) {
        TLoaders.errorSnackBar(
          title: 'Ối đã xảy ra sự cố',
          message: result['message'],
        );
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      if (kDebugMode) {
        print('Error occurred: $e');
      }
      TLoaders.errorSnackBar(
          title: 'Xảy ra lỗi rồi!',
          message: 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau');
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
