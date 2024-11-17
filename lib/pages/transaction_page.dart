// ignore_for_file: avoid_print

import 'package:capbank/pages/new_category_page.dart';
import 'package:capbank/service/category/category_dto.dart';
import 'package:capbank/service/category/category_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  final int id;
  final String transactionDate;

  const TransactionPage({
    super.key,
    required this.id,
    required this.transactionDate,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int _operation = 1;
  String? _selectedCategory; // Categoria selecionada na caixa de combinação
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // Formatação para valores monetários
  final NumberFormat _currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'pt_BR');

  final categoryService = CategoryService();
  List<CategoryDTO> _categories = [];

  Future<void> _loadCategories() async {
    print('load acionado $_operation ');
    List<CategoryDTO> categories = await categoryService.getByType(_operation);
    setState(() {
      _categories = categories;
    });
    print('Categorias carregadas: ${categories.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo lançamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${widget.id}'),
            Text('Data: ${widget.transactionDate}'),
            const SizedBox(height: 16.0),

            // Radio Buttons para operação
            const Text('Tipo de Operação'),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: _operation,
                  onChanged: (value) {
                    setState(() {
                      _operation = value!;
                    });
                    _loadCategories();
                  },
                ),
                const Text('Crédito'),
                Radio(
                  value: 1,
                  groupValue: _operation,
                  onChanged: (value) {
                    setState(() {
                      _operation = value!;
                    });
                    _loadCategories();
                  },
                ),
                const Text('Débito'),
              ],
            ),

            const SizedBox(height: 16.0),
            const Text('Categoria'),
            Row(
              children: [
                DropdownButton<String>(
                  hint: const Text('Selecione uma categoria'),
                  value: _selectedCategory,
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value:
                          category.id, // Armazena o id da categoria selecionada
                      child: Text(category.description), // Exibe a descrição
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                FloatingActionButton(onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const NewCategoryPage()));
                }),
              ],
            ),

            // Campo de texto para descrição
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),

            // Campo de texto para valor com formatação para reais
            const SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TextInputFormatter.withFunction(
                  (oldValue, newValue) {
                    final value = double.parse(newValue.text) / 100;
                    return newValue.copyWith(
                      text: _currencyFormatter.format(value),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24.0),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Cancelar');
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('salvar');
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
