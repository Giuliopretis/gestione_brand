import 'package:flutter/material.dart';
import 'package:gestione_brand/business_logic/states/state_controller.dart';
import 'package:gestione_brand/data/api_provider.dart';
import 'package:gestione_brand/data/classes/dialog_action.dart';
import 'package:gestione_brand/presentation/widgets/brand_list.dart';
import 'package:gestione_brand/presentation/widgets/dynamic_dialog.dart';
import 'package:get/get.dart' hide Response;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StateController stateController = Get.find();
  ApiProvider apiProvider = ApiProvider();

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

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
        content: _addBrandDialogContent(),
        actions: [
          DialogAction(
              text: 'Annulla', callback: () => Get.back(), isPositive: false),
          DialogAction(
              text: 'Aggiungi',
              callback: () => validateAndAddBrand(),
              isPositive: true),
        ],
      ),
    );
  }

  void validateAndAddBrand() async {
    bool isValid = formKey.currentState!.validate();
    if (isValid) {
      Map data = {'name': nameController.text};
      var res = await apiProvider.createBrand(data);
      if (res.statusCode == 200 || res.statusCode == 201) {
        nameController.clear();
        stateController.loadBrands();
        showSuccessCreatedBrandSnackbar();
        Get.back();
        return;
      }
      showUnsuccessCreatedBrandSnackbar();
    }
  }

  void showSuccessCreatedBrandSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Brand caricato con successo'),
      backgroundColor: Colors.green,
    ));
  }

  void showUnsuccessCreatedBrandSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Errore durante il caricamento'),
      backgroundColor: Colors.red,
    ));
  }

  Widget _addBrandDialogContent() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            validator: (input) {
              if (input!.isEmpty) {
                return 'Il nome non può essere vuoto';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              label: Text('Nome'),
            ),
          ),
        ],
      ),
    );
  }
}
