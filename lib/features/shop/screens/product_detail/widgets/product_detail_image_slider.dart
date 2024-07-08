import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kgrill_mobile/common/widgets/appbar/appbar.dart';
import 'package:kgrill_mobile/common/widgets/icons/t_circular_icon.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';

import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkerGrey : TColors.light,
        child: Stack(
          children: [
            TCurvedEdgesWidget(
              child: Container(
                color: dark ? TColors.darkerGrey : TColors.light,
                child: Stack(
                  children: [
                    /// Main Large Image
                    const SizedBox(
                      height: 400,
                      child: Padding(
                        padding: EdgeInsets.all(TSizes.productImageRadius*1.4),
                        child: Center(
                          child:
                              Image(image: AssetImage(TImages.productImages2)),
                        ),
                      ),
                    ),

                    /// Image Slider
                    Positioned(
                      right: 0,
                      bottom: 25,
                      left: TSizes.defaultSpace,
                      child: SizedBox(
                        height: 80,
                        child: ListView.separated(
                          itemCount: 4,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          separatorBuilder: (_, __) => const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),
                          itemBuilder: (_, index) => TRoundedImage(
                            width: 80,
                            borderRadius: 10,
                            backgroundColor: dark ? TColors.dark : TColors.white,
                            border: Border.all(color: dark ? TColors.darkerGrey : TColors.white),
                            padding: const EdgeInsets.all(TSizes.xs),
                            imageUrl: TImages.productImages1,
                          ),
                        ),
                      ),
                    ),

                    ///Appbar Icons
                    const TAppBar(
                      showBackArrow: true,
                      actions: [
                        TCircularIcon(
                          icon: Iconsax.heart5,
                          color: Colors.red,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Stack
          ],
        ),
      ),
    );
  }
}
