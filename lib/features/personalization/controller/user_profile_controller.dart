import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/services/personalization/user_profile_service.dart';
import '../screens/profile/profile.dart';

class UserProfileController extends GetxController {
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  final dob = TextEditingController();
  final gender = TextEditingController();
  final address = TextEditingController();
  final secureStorage = const FlutterSecureStorage();
  final imageUploading = false.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  ProfileScreenState? profileScreenState;

  // Future<void> emailAndPasswordSignIn() async {
  //   try {
  //     //start loading
  //     TFullScreenLoader.openLoadingDialog(
  //         'Đang xử lí chờ xíu...', TImages.screenLoadingSparkle2);
  //
  //     //check internet connectivity
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }
  //
  //     //form validation
  //     if (!loginFormKey.currentState!.validate()) {
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }
  //
  //     // final result = await AuthenticationService().handleSignIn(
  //     //   email: email.text,
  //     //   password: password.text,
  //     // );
  //
  //     TFullScreenLoader.stopLoading();
  //   } catch (e) {
  //     TFullScreenLoader.stopLoading();
  //     if (kDebugMode) {
  //       print('Error occurred: $e');
  //     }
  //     TLoaders.errorSnackBar(
  //         title: 'Xảy ra lỗi rồi!',
  //         message: 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau');
  //   }
  // }

  Future<void> handleImageProfileUpload() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
          maxHeight: 1200,
          maxWidth: 1200);

      ///can do a image crop right here
      if (image != null) {
        TFullScreenLoader.openLoadingDialog(
            'Đang xử lí chờ xíu...', TImages.screenLoadingSparkle4);

        imageUploading.value = true;

        final result =
            await UserProfileService().updateUserProfilePicture(image);
        TFullScreenLoader.stopLoading();

        if (result['success'] == true) {
          TLoaders.successSnackBar(
              title: 'Thành công', message: 'Cập nhật ảnh đại diện thành công');
          profileScreenState?.loadUserProfile();
        } else {
          TLoaders.errorSnackBar(
              title: 'Xảy ra lỗi rồi!', message: result['message']);
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Xảy ra lỗi rồi!',
          message: 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau');
    }
    finally{
      imageUploading.value = false;
    }
  }
}
