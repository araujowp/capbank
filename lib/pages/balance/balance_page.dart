// ignore_for_file: avoid_print

import 'package:capbank/pages/balance/widget/amount_display.dart';
import 'package:capbank/components/plus_button.dart';
import 'package:capbank/pages/balance/widget/transaction_card.dart';
import 'package:capbank/pages/new_transaction_page.dart';
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

  DateTime balanceDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, 23, 59, 59);

  late Future balanceFuture;

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  void _loadBalance() {
    setState(() {
      balanceFuture =
          balanceService.getBalance(widget.id.toString(), balanceDate);
    });
  }

  void _previousBalance() {
    balanceDate = balanceDate.add(const Duration(days: -1));
    _loadBalance();
  }

  void _nextBalance() {
    balanceDate = balanceDate.add(const Duration(days: 1));
    _loadBalance();
  }

  TextStyle _getTextStyle(bool large) {
    return large
        ? TextStyle(color: Theme.of(context).textTheme.titleLarge!.color)
        : TextStyle(color: Theme.of(context).textTheme.titleSmall!.color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(style: _getTextStyle(true), 'Saldo'),
                        ),
                        AmountDisplay(
                          amount: balance.amount,
                          date: balance.date,
                          forWard: _nextBalance,
                          backWard: _previousBalance,
                        ),
                        Text(style: _getTextStyle(true), 'Lançamentos'),
                        Expanded(
                          child: ListView.builder(
                            itemCount: balance.transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = balance.transactions[index];
                              return TransactionCard(
                                amount: transaction.amount,
                                description: transaction.description,
                                category: transaction.category.description,
                                operation: transaction.category.type,
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
                                builder: (_) => NewTransactionPage(
                                  id: widget.id,
                                  picture: widget.photo,
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
