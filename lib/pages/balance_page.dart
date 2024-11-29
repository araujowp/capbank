import 'package:capbank/components/amount_display.dart';
import 'package:capbank/components/plus_button.dart';
import 'package:capbank/components/transaction_card.dart';
import 'package:capbank/pages/transaction_page.dart';
import 'package:capbank/service/balance/balance_service.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatefulWidget {
  final int id;
  final String name;
  final String photo;

  const BalancePage({
    super.key,
    required this.id,
    required this.name,
    required this.photo,
  });

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final BalanceService balanceService = BalanceService();

  late Future balanceFuture;

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  void _loadBalance() {
    setState(() {
      balanceFuture =
          balanceService.getBalance(widget.id.toString(), DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá, ${widget.name}"),
      ),
      body: Center(
        child: FutureBuilder(
          future: balanceFuture,
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
                        const Text('Saldo'),
                        AmountDisplay(
                          amount: balance.amount,
                          date: balance.date,
                        ),
                        const Text('Últimos lançamentos'),
                        Expanded(
                          child: ListView.builder(
                            itemCount: balance.transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = balance.transactions[index];
                              return TransactionCard(
                                amount: transaction.amount,
                                description: transaction.description,
                                category: transaction.category.description,
                                operation: transaction.category.type.toString(),
                              );
                            },
                          ),
                        ),
                        PlusButton(
                          size: 60.0,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TransactionPage(
                                  id: widget.id,
                                  transactionDate: balance.date,
                                ),
                              ),
                            ).then((_) {
                              _loadBalance();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
