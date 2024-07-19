import 'package:get/get.dart';
import 'package:kgrill_mobile/data/services/shop/order_service.dart';
import '../models/order_model.dart';

class OrderController extends GetxController {
  var isLoading = true.obs;
  var orders = <OrderModel>[].obs;
  final OrderService orderService = OrderService();

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    isLoading.value = true;
    await orderService.fetchOrderHistory();
    orders.value = orderService.orders.value;
    isLoading.value = false;
  }
}
