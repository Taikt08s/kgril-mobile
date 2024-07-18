import 'package:flutter/material.dart';
import 'package:kgrill_mobile/common/widgets/appbar/appbar.dart';
import 'package:kgrill_mobile/features/shop/screens/order/widgets/orders_list.dart';
import 'package:kgrill_mobile/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: false,
          title: Text('Lịch sử đặt hàng',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(color: TColors.white))),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: TOrderListItems(),
      ),
    );
  }
}
