// ignore_for_file: avoid_print

import 'package:capbank/service/category/category_dto_new.dart';
import 'package:capbank/service/category/category_service.dart';
import 'package:currency_textfield/currency_textfield.dart';
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

  final _currencyController = CurrencyTextFieldController(
      decimalSymbol: ',',
      thousandSymbol: '.',
      currencySymbol: 'R\$',
      enableNegative: false, // Desativa valores negativos
      minValue: 0.01,
      initDoubleValue: 0.00);

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _onCancel() {
    _descriptionController.clear();
    Navigator.pop(context);
  }

  bool _onValidation() {
    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Favor informe a descrição !',
              style: TextStyle(color: Colors.green)),
          backgroundColor: Colors.yellow,
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  Future<void> _onSubmit() async {
    if (!_onValidation()) {
      return;
    }

    final String description = _descriptionController.text;

    final newCategory = CategoryDTONew(
        description: description, //
        type: _selectedType, //
        sugestedValue: _currencyController.doubleValue);

    bool result = await categoryService.add(newCategory);

    if (result) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Categoria adicionada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao adicionar categoria. Tente novamente!'),
          backgroundColor: Colors.red,
        ),
      );
    }

    _descriptionController.clear();
    _currencyController.clear();
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
            TextField(
              controller: _currencyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor Sugerido',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _onCancel,
                  child: const Text("Voltar"),
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
