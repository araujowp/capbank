import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  final String id;
  final String name;
  final String photo;

  const BalancePage({
    super.key,
    required this.id,
    required this.name,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá, $name"),
      ),
      body: Center(
        child: Text(" corpo da pagina $id - $name"),
      ),
    );
  }
}
