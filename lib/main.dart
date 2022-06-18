import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestione_brand/business_logic/blocs/bloc/brand_bloc.dart';
import 'package:gestione_brand/business_logic/states/search_brands_controller.dart';
import 'package:gestione_brand/business_logic/states/state_controller.dart';
import 'package:gestione_brand/presentation/pages/home_page.dart';
import 'package:get/get.dart';

void main() {
  Get.lazyPut(() => StateController(), fenix: true);
  Get.lazyPut(() => SearchBrandsController(), fenix: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (create) => BrandBloc()..add(LoadBrands()),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const HomePage(),
      ),
    );
  }
}
