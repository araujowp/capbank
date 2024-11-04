import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo lançamento'),
      ),
      body: const Center(
        child: Text('corp'),
      ),
    );
  }
}
