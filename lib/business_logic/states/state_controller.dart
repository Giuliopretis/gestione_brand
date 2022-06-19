import 'package:gestione_brand/data/api_provider.dart';
import 'package:gestione_brand/data/models/brand.dart';
import 'package:get/state_manager.dart';

class StateController extends GetxController {
  RxBool isLoadingBrands = false.obs;
  RxList<Brand> brands = <Brand>[].obs;

  ApiProvider apiProvider = ApiProvider();

  void loadBrands() async {
    isLoadingBrands.value = true;
    try {
      brands.value = await apiProvider.getBrandList();
      isLoadingBrands.value = false;
    } catch (e) {
      isLoadingBrands.value = false;
      rethrow;
    }
  }
}
