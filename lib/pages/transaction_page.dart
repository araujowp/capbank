// ignore_for_file: avoid_print

import 'package:capbank/pages/new_category_page.dart';
import 'package:capbank/service/category/category_dto.dart';
import 'package:capbank/service/category/category_service.dart';
import 'package:capbank/service/transaction/transaction_dto_new.dart';
import 'package:capbank/service/transaction/transaction_service.dart';
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
  CategoryDTO? _selectedCategory;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // Formatação para valores monetários
  final NumberFormat _currencyFormatter =
      NumberFormat.simpleCurrency(locale: 'pt_BR');

  final categoryService = CategoryService();
  List<CategoryDTO> _categories = [];
  final transactionService = TransactionService();

  @override
  void initState() {
    print('passei no initstate ');
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    print('load acionado $_operation ');
    List<CategoryDTO> categories = await categoryService.getByType(_operation);
    setState(() {
      _categories = categories;
    });
    print('Categorias carregadas: ${categories.length}');
    print('opção carregada  $_operation ');
  }

  Future<void> _addTransaction() async {
    final String description = _descriptionController.text;

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione uma categoria.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String amountText = _amountController.text;
    amountText = amountText.replaceAll(RegExp(r'[^\d.]'), '');
    double amount = double.tryParse(amountText) ?? 0.0;

    print('Valor capturado: $amount');
    print("categoria selecionada ${_selectedCategory?.description}");
    print("categoria selecionada id ${_selectedCategory?.id}");
    print("categoria selecionada type ${_selectedCategory?.type}");

    final newTransactioDto = TransactionDtoNew(
        description: description, //
        amount: amount, //
        transactionDate: DateTime.now(), //
        category: _selectedCategory!, //
        userId: widget.id.toString());
    print("geramos o new transaction ");

    bool result = await transactionService.add(newTransactioDto);

    if (result) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lançamento adicionado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Notificação de falha
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao adicionar lançamento. Tente novamente!'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                  value: 1,
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
                  value: 2,
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
                DropdownButton<CategoryDTO>(
                  hint: const Text('Selecione uma categoria'),
                  value: _selectedCategory,
                  items: _categories.map((category) {
                    return DropdownMenuItem<CategoryDTO>(
                      value: category,
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
                    _addTransaction();
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
