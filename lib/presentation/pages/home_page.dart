import 'package:flutter/material.dart';
import 'package:gestione_brand/business_logic/states/state_controller.dart';
import 'package:gestione_brand/data/models/brand.dart';
import 'package:gestione_brand/presentation/widgets/brand_list.dart';
import 'package:gestione_brand/presentation/widgets/search_bar.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StateController stateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brands')),
      body: Column(
        children: const [
          Expanded(child: BrandList()),
        ],
      ),
    );
  }
}
