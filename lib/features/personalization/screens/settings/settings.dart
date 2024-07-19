import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:kgrill_mobile/common/widgets/appbar/appbar.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:kgrill_mobile/common/widgets/list_titles/settings_menu_title.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';
import 'package:kgrill_mobile/features/shop/screens/cart/cart.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';
import 'package:kgrill_mobile/utils/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/widgets/effects/shimmer_effect.dart';
import '../../../../common/widgets/list_titles/t_user_profile_title.dart';
import '../../../../data/services/personalization/user_profile_service.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../authentication/controllers/logout/logout_controller.dart';
import '../../controller/user_profile_controller.dart';
import '../address/address_picker.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final controller = Get.put(LogoutController());
  final userController = Get.put(UserProfileController());
  String? _selectedAddress;
  bool _locationSharingEnabled = false;
  Map<String, dynamic>? userProfile;
  ScaffoldMessengerState? _scaffoldMessengerState;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _loadUserProfile();
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    setState(() {
      _locationSharingEnabled = status.isGranted;
    });
  }

  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    setState(() {
      _locationSharingEnabled = status.isGranted;
    });
  }

  Future<void> _loadUserProfile() async {
    var result = await UserProfileService().getUserProfile();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userProfile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  ///Header
                  TPrimaryHeaderContainer(
                    child: Column(
                      children: [
                        TAppBar(
                            title: Text('Thiết lập tài khoản',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .apply(color: TColors.white)),
                            showBackArrow: false),

                        ///User Profile Card
                        Obx(() {
                          final profilePicture = userController
                              .userUpdateProfile['data']?['profile_picture'];
                          final networkImage = (profilePicture == null ||
                                  profilePicture == "null")
                              ? TImages.grillIcon
                              : profilePicture;
                          if (userController.profileLoading.value) {
                            return const TShimmerEffect(
                                width: 100, height: 100);
                          } else {
                            return TUserProfileTitle(
                              onPressed: () =>
                                  Get.to(() => const ProfileScreen()),
                              fullName:
                                  '${userController.firstName.text} ${userController.lastName.text}',
                              email: userProfile?['data']['email'],
                              profilePicture: networkImage,
                              isNetworkImage: !(userProfile?['data']
                                          ['profile_picture'] ==
                                      null ||
                                  userProfile?['data']['profile_picture'] ==
                                      "null"),
                            );
                          }
                        }),
                        const SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  ),

                  ///Body
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        ///Account Settings
                        const TSectionHeading(
                            title: 'Tài khoản', showActionButton: false),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        TSettingsMenuTile(
                          icon: Iconsax.user_octagon,
                          title: 'Tài Khoản & Bảo Mật',
                          subtitle: 'Thiết lập tài khoản',
                          onTap: () => Get.to(() => const ProfileScreen()),
                        ),
                        TSettingsMenuTile(
                          icon: Iconsax.safe_home,
                          title: 'Địa Chỉ',
                          subtitle:
                              _selectedAddress ?? 'Thiết lập địa chỉ giao hàng',
                          onTap: () async {
                            final result =
                                await Get.to(() => const LocationPicker());
                            if (result != null &&
                                result is Map<String, dynamic>) {
                              setState(() {
                                _selectedAddress = result['address'];
                              });
                            }
                          },
                        ),
                        TSettingsMenuTile(
                          icon: Iconsax.shopping_cart,
                          title: 'Giỏ Hàng',
                          subtitle: 'Chỉnh sửa giỏ hàng',
                          onTap: () => Get.to(() => const CartScreen()),
                        ),
                        TSettingsMenuTile(
                          icon: Iconsax.card,
                          title: 'Thẻ Ngân Hàng',
                          subtitle: 'Thiết lập phương thức thanh toán',
                          onTap: () {},
                        ),
                        TSettingsMenuTile(
                          icon: Iconsax.ticket_discount,
                          title: 'Mã Giảm Giá',
                          subtitle: 'Các mã giảm giá sẵn có',
                          onTap: () {},
                        ),
                        const TSectionHeading(
                            title: 'Cài đặt', showActionButton: false),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TSettingsMenuTile(
                          icon: Iconsax.message_question,
                          title: 'Chia sẻ vị trí',
                          subtitle: 'Cài đặt vị trí hiện tại',
                          trailing: Switch(
                            value: _locationSharingEnabled,
                            onChanged: (value) async {
                              if (value) {
                                await _requestLocationPermission();
                              } else {
                                setState(() {
                                  _locationSharingEnabled = false;
                                });
                              }
                            },
                          ),
                        ),
                        TSettingsMenuTile(
                          icon: Iconsax.notification,
                          title: 'Thông Báo',
                          subtitle: 'Cài đặt thông báo',
                          onTap: () {},
                        ),
                        TSettingsMenuTile(
                          icon: Iconsax.message_question,
                          title: 'Trung Tâm Trợ Giúp',
                          subtitle: 'Hỗ trợ đến từ nhân viên tư vấn',
                          onTap: () {},
                        ),

                        ///Logout
                        const SizedBox(height: TSizes.spaceBtwSections),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => logoutAccountWarningPopup(),
                            child: const Text('Đăng xuất'),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void logoutAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Đăng xuất',
      middleText: 'Điều này sẽ đưa bạn trở về trang đăng nhập',
      confirm: ElevatedButton(
        onPressed: () async => controller.logout(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: TSizes.lg),
            child: Text('Đồng ý')),
      ),
      // ElevatedButton
      cancel: OutlinedButton(
        child: const Text('Hủy bỏ'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ), // OutlinedButton
    );
  }
}
