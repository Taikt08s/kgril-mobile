import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kgrill_mobile/features/personalization/screens/settings/settings.dart';
import 'package:kgrill_mobile/features/shop/screens/store/store.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';
import 'package:kgrill_mobile/utils/helpers/helper_functions.dart';

import 'features/shop/screens/home/home.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark ? TColors.black : TColors.white,
          indicatorColor: dark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.like_1), label: 'Gợi ý'),
            NavigationDestination(
                icon: Icon(Iconsax.shop), label: 'Trang chủ'),
            NavigationDestination(icon: Icon(Iconsax.receipt), label: 'Đơn mua'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Tôi'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const Store(),
    Container(
      color: Colors.orange,
    ),
    const SettingsScreen(),
  ];
}
