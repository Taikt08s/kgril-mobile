import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';
import 'package:kgrill_mobile/utils/popups/full_screen_loader.dart';
import 'package:kgrill_mobile/utils/popups/loaders.dart';

import '../../../../data/services/authentication/authentication_service.dart';
import '../../../../utils/helpers/network_manager.dart';

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

  Future<void> signup() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog(
          'Đang xử lí chờ xíu...', TImages.screenLoading);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //form validation
      if (!signupFormKey.currentState!.validate()) return;
      //policy check
      if (!policy.value) {
        TLoaders.warningSnackBar(
            title: 'Vui lòng chấp nhận điều khoản',
            message:
                'Những điều khoản về chính sách và bảo mật là cần thiết để sử dụng dịch vụ của chúng tôi');
        return;
      }

      AuthenticationService().handleSignUp(
        email: email.text,
        firstName: firstName.text,
        lastName: lastName.text,
        address: address.text,
        phone: phone.text,
        password: password.text,
      );

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Xảy ra lỗi rồi!', message: e.toString());
    }
  }
}
