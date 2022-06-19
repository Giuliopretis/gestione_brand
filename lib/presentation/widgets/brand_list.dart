import 'package:flutter/material.dart';
import 'package:gestione_brand/business_logic/states/search_brands_controller.dart';
import 'package:gestione_brand/business_logic/states/state_controller.dart';
import 'package:gestione_brand/data/api_provider.dart';
import 'package:gestione_brand/data/classes/dialog_action.dart';
import 'package:gestione_brand/data/models/brand.dart';
import 'package:gestione_brand/presentation/widgets/dynamic_dialog.dart';
import 'package:gestione_brand/presentation/widgets/search_bar.dart';
import 'package:get/get.dart';

class BrandList extends StatefulWidget {
  const BrandList({Key? key}) : super(key: key);

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  StateController stateController = Get.find();
  SearchBrandsController searchBrandsController = Get.find();
  ApiProvider apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    stateController.loadBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          const SizedBox(height: 8),
          SearchBar(
              hintText: 'Cerca il brand',
              onSearch: (query) => _searchBrands(query)),
          const SizedBox(height: 8),
          Expanded(
            child: stateController.isLoadingBrands.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async => stateController.loadBrands,
                    child: ListView.builder(
                        itemCount: searchBrandsController.isSearching.value
                            ? searchBrandsController.searchedBrands.length
                            : stateController.brands.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Brand brand = searchBrandsController.isSearching.value
                              ? searchBrandsController.searchedBrands[index]
                              : stateController.brands[index];
                          return Dismissible(
                            background: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              _showDeleteDialog(brand);
                            },
                            key: UniqueKey(),
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                              ),
                              child: ListTile(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                ),
                                trailing: const Icon(Icons.record_voice_over),
                                title: Text(brand.name),
                                subtitle: Text(brand.createdAt.toString()),
                                onTap: () {},
                                // onLongPress: () => _showEditDialog(phrase),
                              ),
                            ),
                          );
                        }),
                  ),
          )
        ],
      );
    });
  }

  void _showDeleteDialog(brand) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return DynamicDialog(
            title: 'Eliminare questo brand?',
            actions: [
              DialogAction(
                  text: 'No',
                  callback: () {
                    Get.back();
                    setState(() {});
                  },
                  isPositive: false),
              DialogAction(
                  text: 'Si',
                  callback: () => _deleteBrand(brand),
                  isPositive: true),
            ],
          );
        });
  }

  void _deleteBrand(brand) async {
    var res = await apiProvider.deleteBrand(brand);
    if (res.statusCode == 204 || res.statusCode == 201) {
      Get.back();
      showSuccessDeletedBrandSnackbar();
      return;
    }
    Get.back();
    showUnsuccessDeletedBrandSnackbar();
  }

  void showSuccessDeletedBrandSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Brand eliminato con successo'),
      backgroundColor: Colors.green,
    ));
  }

  void showUnsuccessDeletedBrandSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Errore durante l\'eliminazione'),
      backgroundColor: Colors.red,
    ));
  }

  void _searchBrands(String query) {
    if (query.isEmpty) {
      searchBrandsController.searchedBrands.clear();
      // setState(() => isSearchingBrand = false);
      searchBrandsController.isSearching.value = false;
      return;
    }
    // setState(() {
    searchBrandsController.isSearching.value = true;
    searchBrandsController.searchedBrands.value = [
      ...stateController.brands
          .where((element) => element.name.toLowerCase().contains(query))
    ];
    // });
    return;
  }
}
