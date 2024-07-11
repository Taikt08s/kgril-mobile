import 'package:flutter/material.dart';
import 'package:kgrill_mobile/common/widgets/appbar/appbar.dart';
import 'package:kgrill_mobile/common/widgets/products/ratings/rating_indicator.dart';
import 'package:kgrill_mobile/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:kgrill_mobile/features/shop/screens/product_reviews/widgets/user_review_cart.dart';
import 'package:kgrill_mobile/utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Nhận xét & đánh giá'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Đánh giá được thực hiện dựa trên các khách hàng đã trải nghiệm dịch vụ của chúng tôi."),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Overall Product Ratings
              const TOverallProductRating(),
              const TRatingBarIndicator(rating: 4.2),
              Row(
                children: [
                  Text('1,413', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              ///User Review
              const UserReviewCard(),
              const UserReviewCard(),

            ],
          ),
        ),
      ),
    );
  }
}
