import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';
import 'package:kgrill_mobile/utils/popups/full_screen_loader.dart';
import 'package:kgrill_mobile/utils/popups/loaders.dart';

import '../../../../data/services/authentication/authentication_service.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///Variables
  final hidePassword = true.obs;
  final policy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
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
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //policy check
      if (!policy.value) {
        TLoaders.warningSnackBar(
            title: 'Vui lòng chấp nhận điều khoản',
            message:
                'Những điều khoản về chính sách và bảo mật là cần thiết để sử dụng dịch vụ của chúng tôi');
        return;
      }

      var result = await AuthenticationService().handleSignUp(
        email: email.text,
        firstName: firstName.text,
        lastName: lastName.text,
        address: address.text,
        phone: phone.text,
        password: password.text,
      );

      TFullScreenLoader.stopLoading();

      if (result['success']) {
        TLoaders.successSnackBar(
            title: 'Đã gửi email với mã otp!',
            message: 'Vui lòng check email để lấy mã otp');
        Get.to(() => VerifyEmailScreen(
              email: email.text.trim(),
            ));
      } else {
        TLoaders.warningSnackBar(
            title: 'Ối đã xảy ra sự cố', message: result['message']);
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Xảy ra lỗi rồi!',
          message: 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau');
    }
  }
}
