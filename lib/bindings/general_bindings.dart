import 'package:get/get.dart';
import 'package:kgrill_mobile/utils/helpers/network_manager.dart';

import '../features/shop/controllers/product/cart_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(CartController());
  }
}
