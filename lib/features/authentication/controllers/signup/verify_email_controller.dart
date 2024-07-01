import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../utils/constants/connection_strings.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/login/login.dart';

class VerifyEmailController extends GetxController {
  var otp = List<String>.filled(6, "").obs;

  @override
  void onInit() {
    setTimerForAutoRedirect();
    super.onInit();
  }

  void verifyEmail() async {
    final token = otp.join('');
    if (token.length != 6) {
      TLoaders.warningSnackBar(
        title: 'Invalid OTP',
        message: 'Please enter a 6-digit OTP',
      );
      return;
    }

    try {
      TFullScreenLoader.openLoadingDialog(
          'Đang xử lí chờ xíu...', TImages.screenLoadingSparkle3);

      final response = await http.post(
        Uri.parse(
            '${TConnectionStrings.deployment}auth/activate-account?token=$token'),
      );

      TFullScreenLoader.stopLoading();

      if (response.statusCode == 200) {
        TFullScreenLoader.stopLoading();
        Get.to(() => SuccessScreen(
            image: TImages.emailAccountSuccess,
            title: TTexts.yourAccountCreatedTitle,
            subTitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () => Get.to(() => const LoginScreen())));
      } else if (response.statusCode == 400) {
        final responseData = json.decode(response.body);
        if (responseData['error'] ==
            'Activation code has expired. A new code has been sent to your email address') {
          TLoaders.warningSnackBar(
            title: 'Xác thực không thành công',
            message:
                'Có vẻ như mã xác nhận đã hết hạn chúng tôi đã gửi mã mới vui lòng kiểm tra email',
          );
          if (kDebugMode) {
            print('Verify failed: ${response.body}');
          }
        } else if (response.statusCode == 400) {
          if (responseData['error'] ==
              'This activation code is invalid as it has been revoked. Please use the latest activation code sent to your email.') {
            TLoaders.errorSnackBar(
              title: 'Xác thực thất bại',
              message:
                  'Mã xác thực của bạn đã không còn hiệu lực vui lòng kiểm tra lại email và nhập mã mới nhất',
            );
          } else {
            TLoaders.warningSnackBar(
              title: 'Xảy ra lỗi rồi!',
              message: 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau',
            );
            if (kDebugMode) {
              print('Verify failed: ${response.body}');
            }
          }
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Xảy ra lỗi rồi!', message: e.toString());
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) {});
  }
}
