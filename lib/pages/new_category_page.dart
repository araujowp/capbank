// ignore_for_file: avoid_print

import 'package:capbank/service/category/category_dto_new.dart';
import 'package:capbank/service/category/category_service.dart';
import 'package:flutter/material.dart';

class NewCategoryPage extends StatefulWidget {
  const NewCategoryPage({super.key});

  @override
  NewCategoryPageState createState() => NewCategoryPageState();
}

class NewCategoryPageState extends State<NewCategoryPage> {
  int _selectedType = 1; // Valor padrão para "Crédito"
  final TextEditingController _descriptionController = TextEditingController();
  final categoryService = CategoryService();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _onCancel() {
    _descriptionController.clear();
    Navigator.pop(context);
  }

  Future<void> _onSubmit() async {
    final String description = _descriptionController.text;
    final int type = _selectedType;

    final newCategory =
        CategoryDTONew(description: description, type: _selectedType);

    bool result = await categoryService.add(newCategory);
    print("Descrição: $description, Tipo: $type -$result ");

    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Categoria"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tipo"),
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: _selectedType,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
                const Text("Crédito"),
                Radio(
                  value: 2,
                  groupValue: _selectedType,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
                const Text("Débito"),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _onCancel,
                  // ignore: deprecated_member_use
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text("Cadastrar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
