import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kgrill_mobile/common/widgets/appbar/appbar.dart';
import 'package:kgrill_mobile/common/widgets/images/t_circular_image.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';
import 'package:kgrill_mobile/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';

import '../../../../data/services/personalization/user_profile_service.dart';
import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileService _userService = UserProfileService();
  Map<String, dynamic>? userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    var result = await _userService.getUserProfile();
    if (result['success']) {
      setState(() {
        userProfile = result['data'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Tài Khoản & Bảo Mật'),
        showBackArrow: true,
      ),
      body: userProfile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                child: Column(
                  children: [
                    ///Profile Picture
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                           TCircularImage(
                              image: userProfile!['data']['profile_picture'] ??
                                  TImages.hotPotIcon,
                              width: 100,
                              height: 100),
                          TextButton(
                              onPressed: () {},
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
                        onPressed: () {},
                        title: 'Tên tài khoản',
                        value: 'Taikt08s'),
                    TProfileMenu(
                        onPressed: () {},
                        title: 'Tên đầy đủ',
                        value: '${userProfile!['first_name']} ${userProfile!['last_name']}'),

                    const Divider(),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSectionHeading(
                        title: 'Thông tin cá nhân', showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TProfileMenu(
                      onPressed: () {},
                      title: 'Email',
                      value: 'styematic@gmail.com',
                      icon: Iconsax.copy,
                    ),
                    TProfileMenu(
                        onPressed: () {},
                        title: 'Số điện thoại',
                        value: '0977544372'),
                    TProfileMenu(
                        onPressed: () {},
                        title: 'Địa chỉ',
                        value: 'Nguyễn Xiển, Quận 9, TP HCM'),
                    TProfileMenu(
                        onPressed: () {}, title: 'Giới tính', value: 'Nam'),
                    TProfileMenu(
                        onPressed: () {},
                        title: 'Ngày sinh',
                        value: '26-10-2003'),
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
            ),
    );
  }
}
