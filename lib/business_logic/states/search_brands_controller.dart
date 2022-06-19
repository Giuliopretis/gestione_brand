import 'package:gestione_brand/data/models/brand.dart';
import 'package:get/get.dart';

class SearchBrandsController extends GetxController {
  RxBool isSearching = false.obs;
  RxList<Brand> searchedBrands = <Brand>[].obs;
}
