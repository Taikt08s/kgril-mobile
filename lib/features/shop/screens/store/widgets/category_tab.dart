import 'package:flutter/material.dart';
import 'package:kgrill_mobile/common/widgets/layouts/grid_layout.dart';
import 'package:kgrill_mobile/common/widgets/products/product_card/product_card_vertical.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/product_model.dart';

class TCategoryTab extends StatelessWidget {
  final List<ProductModel> products;

  const TCategoryTab({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                // -- Products
                TSectionHeading(
                    title: 'Dành cho bạn',
                    showActionButton: false,
                    onPressed: () {}),
                const SizedBox(height: TSizes.spaceBtwItems),

                TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) =>
                        TProductCardVertical(product: products[index])),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ), // Column
          ),
        ]); // Padding
  }
}
