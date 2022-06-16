import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestione_brand/business_logic/blocs/bloc/brand_bloc.dart';
import 'package:gestione_brand/data/models/brand.dart';
import 'package:gestione_brand/presentation/widgets/brand_list.dart';
import 'package:gestione_brand/presentation/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Brand> searchedBrands = [];
  bool isSearchingBrand = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 8),
          SearchBar(
              hintText: 'Cerca un brand',
              onSearch: (query) => _searchJobs(query)),
          const SizedBox(height: 8),
          const BrandList(),
        ],
      ),
    );
  }

  void _searchJobs(String query) {
    if (query.isEmpty) {
      searchedBrands.clear();
      setState(() => isSearchingBrand = false);
      return;
    }
    setState(() {
      isSearchingBrand = true;
      // searchedBrands = BlocProvider.of<BrandBloc>(context).state.props;
      // ..._stateController.seletcedJobsForPrint
      //     .where((element) => element.label.toLowerCase().contains(query))
      // ];
    });
    return;
  }
}
