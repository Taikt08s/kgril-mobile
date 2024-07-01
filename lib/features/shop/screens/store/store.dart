import 'package:flutter/material.dart';
import 'package:kgrill_mobile/common/widgets/appbar/appbar.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:kgrill_mobile/common/widgets/layouts/grid_layout.dart';
import 'package:kgrill_mobile/common/widgets/products/cart_menu_icon.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';

import 'package:kgrill_mobile/utils/constants/sizes.dart';
import 'package:kgrill_mobile/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import '../../../../utils/constants/enums.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Trang chủ',
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCartCounterIcon(
            onPressed: () {},
            iconColor: Colors.black,
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context)
                  ? TColors.black
                  : TColors.white,
              expandedHeight: 300,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ///search bar
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSearchContainer(
                      text: 'Tìm trong Kgrill',
                      showBorder: true,
                      showBackground: false,
                      padding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    ///Store categories
                    TSectionHeading(title: 'Danh mục', onPressed: () {}),
                    const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                    ///Categories
                    TGridLayout(itemCount: 2,mainAxisExtent: 80, itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: TRoundedContainer(
                            padding: const EdgeInsets.all(TSizes.xs/2),
                            showBorder: true,
                            backgroundColor: Colors.transparent,
                            child: Row(
                              children: [
                                ///Icon
                                const Flexible(
                                  child: TCircularImage(
                                    image: TImages.grillIcon,
                                    isNetworkImage: false,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                const SizedBox(
                                    height: TSizes.spaceBtwItems / 4),

                                ///Text
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const TBrandTitleWithVerifiedIcon(
                                          title: 'Nướng',
                                          brandTextSize: TextSizes.large),
                                      Text(
                                        '10 combo',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: Container(),
      ),
    );
  }
}
