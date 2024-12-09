// ignore_for_file: avoid_print

import 'package:capbank/components/custom_title.dart';
import 'package:capbank/components/plus_button.dart';
import 'package:capbank/pages/new_category_page.dart';
import 'package:capbank/service/category/category_dto.dart';
import 'package:capbank/service/category/category_service.dart';
import 'package:capbank/service/transaction/transaction_dto_new.dart';
import 'package:capbank/service/transaction/transaction_service.dart';
import 'package:capbank/util/util_format.dart';
import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';

class NewTransactionPage extends StatefulWidget {
  final int id;
  final String picture;
  final DateTime transactionDate;

  const NewTransactionPage({
    super.key,
    required this.id,
    required this.picture,
    required this.transactionDate,
  });

  @override
  State<NewTransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<NewTransactionPage> {
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
    _selectedCategory = null;
    _currencyController.text = "";
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
        transactionDate: widget.transactionDate, //
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

  TextStyle _getTextStyle(bool large) {
    return large
        ? TextStyle(color: Theme.of(context).textTheme.titleLarge!.color)
        : TextStyle(color: Theme.of(context).textTheme.titleSmall!.color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTitle('Novo Lançamento', widget.picture),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  style: _getTextStyle(true),
                  'Data lançamento: ${UtilFormat.toDate(widget.transactionDate)}'),
              const SizedBox(height: 16.0),
              Text(
                'Tipo de Operação',
                style: _getTextStyle(true),
              ),
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
                  Text(
                    'Crédito',
                    style: _getTextStyle(true),
                  ),
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
                  Text(
                    'Débito',
                    style: _getTextStyle(true),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'Categoria',
                style: _getTextStyle(true),
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<CategoryDTO>(
                      icon: const Icon(Icons.category_outlined),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                      isExpanded: true,
                      hint: Text(
                        'Selecione uma categoria',
                        style: _getTextStyle(true),
                      ),
                      value: _selectedCategory,
                      items: _categories.map((category) {
                        return DropdownMenuItem<CategoryDTO>(
                          value: category,
                          child: Text(
                            category.description,
                            style: _getTextStyle(true),
                          ), // Exibe a descrição
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            _selectedCategory = value;
                            _currencyController.forceValue(
                                initDoubleValue: value.sugestedValue);
                          } else {
                            print('clicou mas esta nula categoria ');
                          }
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
                                builder: (_) =>
                                    NewCategoryPage(widget.picture))).then((_) {
                          _loadCategories();
                        });
                      }),
                ],
              ),
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
                  )),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
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
