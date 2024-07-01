import 'package:flutter/material.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: TSizes.defaultSpace),
      child: Column(
        children: [
          Column(
            children: [
              const TSectionHeading(
                title: 'Đề xuất cho bạn',
                showActionButton: false,
                textColor: TColors.white,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Categories
              SizedBox(
                height: 120,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return TVerticalImageText(
                      image: TImages.twoPeopleIcon,
                      title: '2-3 người',
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}