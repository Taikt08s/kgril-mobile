import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kgrill_mobile/common/widgets/appbar/appbar.dart';
import 'package:kgrill_mobile/common/widgets/images/t_circular_image.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';
import 'package:kgrill_mobile/features/personalization/screens/profile/widgets/change_address.dart';
import 'package:kgrill_mobile/features/personalization/screens/profile/widgets/change_date_of_birth.dart';
import 'package:kgrill_mobile/features/personalization/screens/profile/widgets/change_gender.dart';
import 'package:kgrill_mobile/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:kgrill_mobile/features/personalization/screens/profile/widgets/change_phone.dart';
import 'package:kgrill_mobile/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';

import '../../../../common/widgets/effects/shimmer_effect.dart';
import '../../../../data/services/personalization/user_profile_service.dart';
import '../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../controller/user_profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final UserProfileService _userService = UserProfileService();
  final userController = Get.put(UserProfileController());
  Map<String, dynamic>? userProfile;
  ScaffoldMessengerState? _scaffoldMessengerState;

  @override
  void initState() {
    super.initState();
    final controller = Get.put(UserProfileController());
    controller.profileScreenState = this;
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    var result = await _userService.getUserProfile();
    if (result['success']) {
      setState(() {
        userProfile = result['data'];
      });
    } else {
      _scaffoldMessengerState?.showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }

  Future<void> loadUserProfile() async {
    await _loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserProfileController());
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Tài Khoản & Bảo Mật'),
        showBackArrow: true,
      ),
      body: Obx(
        () {
          if (userController.profileLoading.value || userProfile == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                child: Column(
                  children: [
                    ///Profile Picture
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Obx(() {
                            final profilePicture = userController
                                .userUpdateProfile['data']?['profile_picture'];
                            final networkImage = (profilePicture == null ||
                                    profilePicture == "null")
                                ? TImages.grillIcon
                                : profilePicture;
                            if (userController.imageUploading.value) {
                              return const TShimmerEffect(
                                  width: 100, height: 100);
                            } else {
                              return TCircularImage(
                                  image: networkImage,
                                  width: 100,
                                  height: 100,
                                  padding: 0,
                                  isNetworkImage: !(profilePicture == null ||
                                      profilePicture == "null"));
                            }
                          }),
                          TextButton(
                              onPressed: () =>
                                  controller.handleImageProfileUpload(),
                              child: const Text('Thay ảnh đại diện'))
                        ],
                      ),
                    ),

                    ///Details
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSectionHeading(
                        title: 'Hồ sơ của tôi', showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TProfileMenu(
                        onPressed: () => Get.to(() => const ChangeUserName()),
                        title: 'Tên tài khoản',
                        value: userController.firstName.text),
                    TProfileMenu(
                        onPressed: () => Get.to(() => const ChangeUserName()),
                        title: 'Tên đầy đủ',
                        value:
                            '${userController.firstName.text} ${userController.lastName.text}'),

                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSectionHeading(
                        title: 'Thông tin cá nhân', showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TProfileMenu(
                      onPressed: () {},
                      title: 'Email',
                      value: '${userProfile?['data']['email']}',
                      icon: Iconsax.copy,
                      onIconPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: userProfile?['data']['email']),
                        );
                      },
                    ),
                    TProfileMenu(
                        onPressed: () =>
                            Get.to(() => const ChangePhoneNumber()),
                        title: 'Số điện thoại',
                        value: userController.phone.text),
                    TProfileMenu(
                        onPressed: () => Get.to(() => const ChangeAddress()),
                        title: 'Địa chỉ',
                        value: userController.address.text),
                    TProfileMenu(
                        onPressed: () => Get.to(() => const ChangeUserGender()),
                        title: 'Giới tính',
                        value: userController.gender.text),
                    TProfileMenu(
                        onPressed: () => Get.to(() => const ChangeUserDob()),
                        title: 'Ngày sinh',
                        value: userController.dob.text),
                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Vô hiệu hóa tài khoản',
                            style: TextStyle(color: Colors.red)),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
