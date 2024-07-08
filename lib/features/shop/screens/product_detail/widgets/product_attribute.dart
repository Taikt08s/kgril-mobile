import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';
import 'package:kgrill_mobile/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// --- Checkout
        SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed: () {}, child: const Text('Mua ngay'))),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// --- Selected Attribute Pricing & Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TSectionHeading(
                      title: 'Gồm có ', showActionButton: false),
                  const SizedBox(height: TSizes.smallSpace),

                  ///Dish Component
                  Row(
                    children: [
                      /// Dish Name
                      const Text(
                        '+ Xúc xích nấm (200g)',
                      ),
                      const SizedBox(width: TSizes.smallSpace),

                      /// Quantity
                      Text(
                        'x1',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      /// Dish Name
                      const Text(
                        '+ Ba chỉ bò Mỹ (250g)',
                      ),
                      const SizedBox(width: TSizes.smallSpace),

                      /// Quantity
                      Text(
                        'x1',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      /// Dish Name
                      const Text(
                        '+ Diềm cơ (200g)',
                      ),
                      const SizedBox(width: TSizes.smallSpace),

                      /// Quantity
                      Text(
                        'x2',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        /// Description
        const SizedBox(height: TSizes.spaceBtwItems),
        const TSectionHeading(title: 'Mô tả', showActionButton: false),
        const SizedBox(height: TSizes.spaceBtwItems),
        const ReadMoreText(
            'Thực đơn bao gồm nhiều món ăn hấp dẫn và phong phú, bắt đầu với xúc xích nấm thơm ngon và ba chỉ bò Mỹ mềm mịn, nướng thơm lừng. Diềm cơ đậm đà và dẻ sườn thấm đẫm gia vị chắc chắn sẽ làm hài lòng những thực khách khó tính nhất. Sốt chấm đặc biệt, đi kèm với nấm tiên (nấm đùi gà) tươi ngon và kim chi cải thảo giòn tan, chua cay hài hòa, tạo nên một bữa ăn trọn vẹn. Bắp Mỹ, khoai và lá nhíp không chỉ bổ sung độ giòn và vị ngọt mà còn thêm phần dinh dưỡng. Ngoài ra, miến Hàn Quốc hoặc mỳ gói Hàn Quốc và món lẩu quân đội đặc trưng cũng góp phần làm cho bữa tiệc thêm phong phú và đa dạng. Giá đã bao gồm 10% VAT, mang đến cho bạn một trải nghiệm ẩm thực hoàn hảo.',
            trimLines: 5,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' mở rộng',
            trimExpandedText: ' thu gọn',
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),

        /// Reviews
        const Divider(),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TSectionHeading(
                title: 'Reviews (69)', showActionButton: false),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.arrow_right_3,
                size: 18,
              ),
            )
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
      ],
    );
  }
}
