import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestione_brand/business_logic/blocs/bloc/brand_bloc.dart';
import 'package:gestione_brand/data/models/brand.dart';

class BrandList extends StatefulWidget {
  const BrandList({Key? key}) : super(key: key);

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandBloc, BrandState>(
      builder: (context, state) {
        if (state is BrandLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BrandLoaded) {
          return state.brands.isEmpty
              ? RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<BrandBloc>(context).add(LoadBrands());
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text('No brands found'),
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<BrandBloc>(context).add(LoadBrands());
                    },
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.brands.length,
                        itemBuilder: (context, index) {
                          Brand brand = state.brands[index];
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
                );
        }
        // if (state is BrandErrorxz) {

        // }
        return Container();
      },
    );
  }
}
