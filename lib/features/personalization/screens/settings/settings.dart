import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:kgrill_mobile/common/widgets/appbar/appbar.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:kgrill_mobile/common/widgets/list_titles/settings_menu_title.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';
import 'package:kgrill_mobile/utils/constants/sizes.dart';

import '../../../../common/widgets/list_titles/t_user_profile_title.dart';
import '../../../authentication/controllers/logout/logout_controller.dart';
import '../address/address-picker.dart';
import '../profile/profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final controller = Get.put(LogoutController());
  String? _selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                              .apply(color: TColors.white))),

                  ///User Profile Card
                  TUserProfileTitle(
                      onPressed: () => Get.to(() => const ProfileScreen())),
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
                    subtitle: _selectedAddress ?? 'Thiết lập địa chỉ giao hàng',
                    onTap: () async {
                      final result = await Get.to(() => const LocationPicker());
                      if (result != null && result is Map<String, dynamic>) {
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
                    onTap: () {},
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
                    trailing: Switch(value: true, onChanged: (value) {}),
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
                    subtitle: 'Cài đặt thông báo',
                    onTap: () {},
                  ),

                  ///Logout
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => controller.logout(),
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
}
