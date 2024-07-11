import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgrill_mobile/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:kgrill_mobile/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';
import 'package:kgrill_mobile/features/shop/controllers/product/product_controller.dart';
import 'package:kgrill_mobile/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:kgrill_mobile/features/shop/screens/home/widgets/home_categories.dart';
import 'package:kgrill_mobile/features/shop/screens/home/widgets/promo_silder.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';

import '../../../../common/widgets/all_products/all_products.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///Appbar
                  SizedBox(height: TSizes.borderRadiusMd),
                  THomeAppbar(),
                  SizedBox(height: TSizes.borderRadiusLg),

                  ///Searchbar
                  TSearchContainer(
                    text: 'Tìm trong KGrill',
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  ///Categories
                  THomeCategories()
                ],
              ),
            ),

            ///Body
            Padding(
              padding: const EdgeInsets.all(TSizes.spaceBtwItems),
              child: Column(
                children: [
                  ///Slider
                  const TPromoSlider(banners: [
                    TImages.bannerImages1,
                    TImages.bannerImages2,
                    TImages.bannerImages3,
                    TImages.bannerImages4,
                  ]),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ///Heading
                  TSectionHeading(
                      title: 'Đề xuất cho bạn',
                      onPressed: () => Get.to(() => const AllProducts())),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ///Popular Products

                  Obx(() {
                    if (controller.isLoading.value) {
                      return const TVerticalProductShimmer();
                    }
                    if (controller.featureProducts.isEmpty) {
                      return Center(
                          child: Text(
                        'Không tìm thấy dữ liệu',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ));
                    }
                    return TGridLayout(
                        itemCount: controller.featureProducts.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                            product: controller.featureProducts[index]));
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
