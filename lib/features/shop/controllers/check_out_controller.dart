import 'package:get/get.dart';

import '../../../common/widgets/success_screen/success_screen.dart';
import '../../../data/services/personalization/user_profile_service.dart';
import '../../../data/services/shop/check_out_service.dart';
import '../../../navigation_dart.dart';
import '../../../utils/constants/image_strings.dart';
import '../models/check_out_model.dart';

class CheckoutController extends GetxController {
  final CheckoutService checkoutService = CheckoutService();
  final UserProfileService userProfileService = UserProfileService();

  Future<void> performCheckout({
    required int deliveryOrderId,
    required double orderValue,
    required String shippingAddress,
    required double latitude,
    required double longitude,
  }) async {

    // Create the CheckoutModel
    final checkoutData = CheckoutModel(
      deliveryOrderId: deliveryOrderId,
      orderValue: orderValue,
      shippedAddress: shippingAddress,
      orderLatitude: latitude,
      orderLongitude: longitude,
      shippingFee: 50000,
      orderPaymentMethod: 'Cash On Delivery',
    );

    // Perform the checkout
    final result = await checkoutService.checkout(checkoutData);

    // Handle the result
    if (result['success'] == true) {
      Get.to(() => SuccessScreen(
        image: TImages.screenLoadingRobin,
        title: 'Đặt hàng thành công!',
        subTitle: 'Chúng tôi đã tiếp nhận đơn và sẽ vận chuyển sớm nhất có thể vui lòng theo dõi trạng thái đơn hàng',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));
    } else {
      Get.snackbar('Checkout Failed', result['message'] as String);
    }
  }
}