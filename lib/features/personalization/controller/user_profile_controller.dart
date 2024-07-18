import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/services/personalization/user_profile_service.dart';
import '../screens/profile/profile.dart';

class UserProfileController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  final dob = TextEditingController();
  final gender = TextEditingController();
  final address = TextEditingController();
  final longitude = TextEditingController();
  final latitude = TextEditingController();
  final secureStorage = const FlutterSecureStorage();
  var userUpdateProfile = {}.obs;
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  ProfileScreenState? profileScreenState;

  final day = Rx<int>(1);
  final month = Rx<String>('Một');
  final year = Rx<int>(DateTime.now().year);

  final List<String> vietnameseMonths = [
    'Một', 'Hai', 'Ba', 'Bốn', 'Năm', 'Sáu', 'Bảy', 'Tám', 'Chín', 'Mười', 'Mười một', 'Mười hai'
  ];

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  String convertMonthToVietnamese(int month) {
    return vietnameseMonths[month - 1];
  }

  int convertVietnameseToMonth(String month) {
    return vietnameseMonths.indexOf(month) + 1;
  }

  Future<void> loadUserProfile() async {
    try {
      profileLoading.value = true;

      var result = await UserProfileService().getUserProfile();

      if (result['success'] == true) {
        userUpdateProfile.value = result['data'];
        // Initialize text controllers with user data
        firstName.text = userUpdateProfile['data']['first_name'];
        lastName.text = userUpdateProfile['data']['last_name'];
        phone.text = userUpdateProfile['data']['phone'];
        dob.text = userUpdateProfile['data']['dob'];
        gender.text = userUpdateProfile['data']['gender'];
        address.text = userUpdateProfile['data']['address'];
        latitude.text = userUpdateProfile['data']['latitude']?.toString() ?? '';
        longitude.text = userUpdateProfile['data']['longitude']?.toString() ?? '';

        final parsedDob = DateTime.parse(userUpdateProfile['data']['dob']);
        day.value = parsedDob.day;
        month.value = convertMonthToVietnamese(parsedDob.month);
        year.value = parsedDob.year;
        profileLoading.value = false;
      } else {
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }finally{
      profileLoading.value = false;
    }
  }

  Future<void> updateUserProfile() async {
    if (profileFormKey.currentState?.validate() ?? false) {
      final newDob = DateTime(
          year.value, convertVietnameseToMonth(month.value), day.value);
      dob.text = DateFormat('yyyy-MM-dd').format(newDob);

      var updatedFields = {
        "first_name": firstName.text,
        "last_name": lastName.text,
        "phone": phone.text,
        "dob": dob.text,
        "gender": gender.text,
        "address": address.text,
        "latitude": double.tryParse(latitude.text) ?? 0.0,
        "longitude": double.tryParse(longitude.text) ?? 0.0,
      };

      final result = await UserProfileService().updateUserProfile(updatedFields);
      if (result['success'] == true) {
        TLoaders.successSnackBar(
            title: 'Thành công', message: 'Cập nhật thành công');
        await loadUserProfile();
      } else {
        TLoaders.errorSnackBar(
            title: 'Xảy ra lỗi rồi!', message: result['message']);
      }
    }
  }

  Future<void> handleImageProfileUpload() async {
    try {
      imageUploading.value = true;
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
          maxHeight: 1200,
          maxWidth: 1200);

      ///can do a image crop right here
      if (image != null) {
        TFullScreenLoader.openLoadingDialog(
            'Đang xử lí chờ xíu...', TImages.screenLoadingSparkle4);

        final result =
            await UserProfileService().updateUserProfilePicture(image);
        imageUploading.value = false;
        TFullScreenLoader.stopLoading();

        if (result['success'] == true) {
          TLoaders.successSnackBar(
              title: 'Thành công', message: 'Cập nhật ảnh đại diện thành công');
          await loadUserProfile();
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
    } finally {
      imageUploading.value = false;
    }
  }
}
