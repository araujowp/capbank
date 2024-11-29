import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final double amount;
  final String description;
  final String category;
  final String operation;

  const TransactionCard({
    super.key,
    required this.amount,
    required this.description,
    required this.category,
    required this.operation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.menu_book,
                    size: 30, color: Theme.of(context).colorScheme.primary),
              )
            ],
          ),
          Column(
            children: [Text(category), Text(description)],
          ),
          Column(
            children: [Text(amount.toStringAsFixed(2))],
          )
        ]),
      ),
    );
  }
}
