import 'package:flutter/material.dart';
import 'package:kgrill_mobile/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:kgrill_mobile/features/shop/screens/home/widgets/home_categories.dart';
import 'package:kgrill_mobile/features/shop/screens/home/widgets/promo_silder.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///Appbar
                  THomeAppbar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  ///Searchbar
                  TSearchContainer(
                    text: 'Search in KGrill',
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),

                  ///Categories
                  THomeCategories()
                ],
              ),
            ),

            ///Body
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TPromoSlider(
                banners: [
                  TImages.bannerImages1,
                  TImages.bannerImages2,
                  TImages.bannerImages3,
                  TImages.bannerImages4,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
