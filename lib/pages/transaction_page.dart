// ignore_for_file: avoid_print

import 'package:capbank/components/plus_button.dart';
import 'package:capbank/pages/new_category_page.dart';
import 'package:capbank/service/category/category_dto.dart';
import 'package:capbank/service/category/category_service.dart';
import 'package:capbank/service/transaction/transaction_dto_new.dart';
import 'package:capbank/service/transaction/transaction_service.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';

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

  // Formatação para valores monetários

  final _currencyController = CurrencyTextFieldController(
      decimalSymbol: ',',
      thousandSymbol: '.',
      currencySymbol: 'R\$',
      enableNegative: false, // Desativa valores negativos
      minValue: 0.01);

  final categoryService = CategoryService();
  List<CategoryDTO> _categories = [];
  final transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    print('load acionado $_operation ');
    List<CategoryDTO> categories = await categoryService.getByType(_operation);
    setState(() {
      _categories = categories;
    });
  }

  bool _formValidation() {
    String message = "";
    if (_selectedCategory == null) {
      message = 'Por favor, selecione uma categoria. \n';
    }

    if (_descriptionController.text.isEmpty) {
      message += 'Favor informar a descrição. \n';
    }

    if (_currencyController.text.isEmpty) {
      message += 'Favor informar o valor. \n ';
    }

    if (message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  void _clear() {
    setState(() {
      _selectedCategory = null;
      _descriptionController.text = "";
      _currencyController.text = "";
    });
  }

  Future<void> _addTransaction() async {
    if (!_formValidation()) {
      return;
    }

    final String description = _descriptionController.text;

    final newTransactioDto = TransactionDtoNew(
        description: description, //
        amount: _currencyController.doubleValue,
        transactionDate: DateTime.now(), //
        category: _selectedCategory!, //
        userId: widget.id.toString());

    bool result = await transactionService.add(newTransactioDto);

    if (result) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lançamento adicionado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      _clear();
    } else {
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
        child: SingleChildScrollView(
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
                  Expanded(
                    child: DropdownButton<CategoryDTO>(
                      isExpanded: true,
                      hint: const Text('Selecione uma categoria'),
                      value: _selectedCategory,
                      items: _categories.map((category) {
                        return DropdownMenuItem<CategoryDTO>(
                          value: category,
                          child:
                              Text(category.description), // Exibe a descrição
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                  ),
                  PlusButton(
                      size: 40,
                      onPressed: () {
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

              const SizedBox(height: 16.0),
              TextField(
                controller: _currencyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor em reais',
                  border: OutlineInputBorder(),
                ),
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
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
