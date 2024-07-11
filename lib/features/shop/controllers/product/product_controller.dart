import 'package:get/get.dart';
import 'package:kgrill_mobile/data/services/shop/product_service.dart';
import 'package:kgrill_mobile/features/shop/models/product_model.dart';
import 'package:kgrill_mobile/utils/popups/loaders.dart';

class ProductController extends GetxController {
  final isLoading = false.obs;
  final productService = Get.put(ProductService());

  static ProductController get instance => Get.find();
  RxList<ProductModel> featureProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeatureProducts();
    super.onInit();
  }

  void fetchFeatureProducts() async {
    try {
      isLoading.value = true;

      final products = await productService.fetchProductData();

      featureProducts.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Xảy ra lỗi rồi!',
          message: 'Đã xảy ra sự cố không xác định, vui lòng thử lại sau');
    } finally {
      isLoading.value = false;
    }
  }
}
