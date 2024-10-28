import 'package:capbank/service/balance/balance_service.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  final BalanceService balanceService = BalanceService();
  final int id;
  final String name;
  final String photo;

  BalancePage({
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
        child: FutureBuilder(
          future: balanceService.getBalance(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Erro ao carregar os dados.'));
            } else {
              final balance = snapshot.data!;
              return Center(child: Text('saldo: ${balance.amount}'));
            }
          },
        ),
      ),
    );
  }
}
