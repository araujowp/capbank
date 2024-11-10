import 'package:flutter/material.dart';

class NewCategoryPage extends StatefulWidget {
  const NewCategoryPage({super.key});

  @override
  _NewCategoryPageState createState() => _NewCategoryPageState();
}

class _NewCategoryPageState extends State<NewCategoryPage> {
  int _selectedType = 1; // Valor padrão para "Crédito"
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _onCancel() {
    // Limpa os campos e volta para a página anterior
    _descriptionController.clear();
    Navigator.pop(context);
  }

  void _onSubmit() {
    final String description = _descriptionController.text;
    final int type = _selectedType;

    // Aqui você pode chamar o serviço para cadastrar a categoria
    print("Descrição: $description, Tipo: $type");

    // Limpa os campos após o cadastro
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
