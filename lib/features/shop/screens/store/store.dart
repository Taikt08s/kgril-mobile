import 'package:flutter/material.dart';
import 'package:kgrill_mobile/common/widgets/appbar/appbar.dart';
import 'package:kgrill_mobile/common/widgets/appbar/tabbar.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:kgrill_mobile/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:kgrill_mobile/common/widgets/layouts/grid_layout.dart';
import 'package:kgrill_mobile/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:kgrill_mobile/common/widgets/texts/section_heading.dart';
import 'package:kgrill_mobile/features/shop/screens/store/widgets/category_tab.dart';
import 'package:kgrill_mobile/utils/constants/colors.dart';
import 'package:kgrill_mobile/utils/constants/image_strings.dart';

import 'package:kgrill_mobile/utils/constants/sizes.dart';
import 'package:kgrill_mobile/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/images/t_circular_image.dart';
import '../../../../common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import '../../../../data/services/shop/product_service.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/product_model.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  late Future<List<ProductModel>> comboNuong;
  late Future<List<ProductModel>> comboLau;
  late Future<List<ProductModel>> comboCom;
  late Future<List<ProductModel>> comboNuongLau;

  @override
  void initState() {
    super.initState();
    ProductService productService = ProductService();
    comboNuong = productService.fetchProductsByType('nướng');
    comboLau = productService.fetchProductsByType('lẩu');
    comboCom = productService.fetchProductsByType('cơm');
    comboNuongLau = productService.fetchProductsByType('nướng + lẩu');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Trang chủ',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: const [
            TCartCounterIcon(
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
                expandedHeight: 380,
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
                      TSectionHeading(title: 'Danh mục', onPressed: () {},showActionButton: false,),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      ///Categories
                      TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: TRoundedContainer(
                              padding: const EdgeInsets.all(TSizes.xs / 2),
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
                                  const SizedBox(height: TSizes.spaceBtwItems / 4),

                                  ///Text
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const TBrandTitleWithVerifiedIcon(
                                            title: 'Nướng',
                                            brandTextSize: TextSizes.large),
                                        Text(
                                          '10 combo',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.labelMedium)
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

                ///Tab
                bottom: const TTabBar(
                  tabs: [
                    Tab(child: Text('Combo Nướng')),
                    Tab(child: Text('Combo Lẩu')),
                    Tab(child: Text('Combo Cơm')),
                    Tab(child: Text('Combo Nướng + Lẩu')),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              FutureBuilder<List<ProductModel>>(
                future: comboNuong,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có sản phẩm'));
                  } else {
                    return TCategoryTab(products: snapshot.data!);
                  }
                },
              ),
              FutureBuilder<List<ProductModel>>(
                future: comboLau,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có sản phẩm'));
                  } else {
                    return TCategoryTab(products: snapshot.data!);
                  }
                },
              ),
              FutureBuilder<List<ProductModel>>(
                future: comboCom,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có sản phẩm'));
                  } else {
                    return TCategoryTab(products: snapshot.data!);
                  }
                },
              ),
              FutureBuilder<List<ProductModel>>(
                future: comboNuongLau,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Không có sản phẩm'));
                  } else {
                    return TCategoryTab(products: snapshot.data!);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
