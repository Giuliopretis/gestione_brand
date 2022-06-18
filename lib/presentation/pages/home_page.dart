import 'package:flutter/material.dart';
import 'package:gestione_brand/business_logic/states/state_controller.dart';
import 'package:gestione_brand/data/classes/dialog_action.dart';
import 'package:gestione_brand/data/models/brand.dart';
import 'package:gestione_brand/presentation/widgets/brand_list.dart';
import 'package:gestione_brand/presentation/widgets/dynamic_dialog.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Aggiungi brand'),
        icon: const Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
        context: context,
        builder: (_) => DynamicDialog(
              title: 'Aggiungere un brand',
              actions: [
                DialogAction(
                    text: 'Annulla', callback: () {}, isPositive: false),
                DialogAction(
                    text: 'Aggiungi', callback: () {}, isPositive: true),
              ],
            ));
  }
}
