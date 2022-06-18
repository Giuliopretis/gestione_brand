import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestione_brand/business_logic/blocs/bloc/brand_bloc.dart';
import 'package:gestione_brand/business_logic/states/search_brands_controller.dart';
import 'package:gestione_brand/business_logic/states/state_controller.dart';
import 'package:gestione_brand/data/models/brand.dart';
import 'package:gestione_brand/presentation/widgets/search_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BrandList extends StatefulWidget {
  const BrandList({Key? key}) : super(key: key);

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  StateController stateController = Get.find();
  SearchBrandsController searchBrandsController = Get.find();

  @override
  void initState() {
    super.initState();
    stateController.loadBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // searchBrandsController.isSearching.value ? Center(child: CircularProgressIndicator(),) :
      return Column(
        children: [
          const SizedBox(height: 8),
          SearchBar(
              hintText: 'Cerca il brand', onSearch: (query) => _searchBrands),
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
                              BlocProvider.of<BrandBloc>(context)
                                  .add(DeleteBrand(brand: brand));
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

  void _searchBrands(String query) {
    if (query.isEmpty) {
      searchBrandsController.searchedBrands.clear();
      // setState(() => isSearchingBrand = false);
      searchBrandsController.isSearching.value = false;
      return;
    }
    setState(() {
      searchBrandsController.isSearching.value = true;
      searchBrandsController.searchedBrands.value = [
        ...stateController.brands
            .where((element) => element.name.toLowerCase().contains(query))
      ];
    });
    return;
  }
}
