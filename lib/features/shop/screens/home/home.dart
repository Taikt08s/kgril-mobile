import 'package:flutter/material.dart';
import 'package:kgrill_mobile/features/shop/screens/home/widgets/home_appbar.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    text: 'Search in Store',
                  ),

                  ///Categories
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            TSectionHeading(
                              title: 'Popular Categories',
                              showActionButton: false,
                            ),
                            SizedBox(height: TSizes.spaceBtwSections),

                            ///Categories
                            SizedBox(
                              height: 80,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 6,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: 56,
                                        height: 56,
                                        padding:
                                            const EdgeInsets.all(TSizes.sm),
                                        decoration: BoxDecoration(
                                          color: TColors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                          child: Image(
                                            image: AssetImage(''),
                                            fit: BoxFit.cover,
                                            color: TColors.dark,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
