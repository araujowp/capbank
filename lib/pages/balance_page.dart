import 'package:capbank/components/amount_display.dart';
import 'package:capbank/components/transaction_card.dart';
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
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('saldo'),
                      AmountDisplay(
                        amount: balance.amount,
                        date: balance.date,
                      ),
                      const Text('Ultimos lançamentos'),
                      Expanded(
                          child: ListView.builder(
                        itemCount: balance.transactions.length,
                        itemBuilder: (context, index) {
                          final transaction = balance.transactions[index];
                          return TransactionCard(
                            amount: transaction.amount,
                            description: transaction.description,
                            category: transaction.category,
                            operation: transaction.operation,
                          );
                        },
                      ))
                    ],
                  )),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
