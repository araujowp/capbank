import 'package:capbank/util/util_format.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final double amount;
  final String description;
  final String category;
  final int operation;

  const TransactionCard({
    super.key,
    required this.amount,
    required this.description,
    required this.category,
    required this.operation,
  });

  TextStyle _getTextStyle(BuildContext context, double fontSize) {
    return operation == 1
        ? TextStyle(
            fontSize: fontSize, color: Theme.of(context).colorScheme.primary)
        : TextStyle(fontSize: fontSize, color: _getColor(context));
  }

  Color _getColor(BuildContext context) {
    return operation == 1
        ? Theme.of(context).colorScheme.primary
        : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.menu_book, size: 30, color: _getColor(context)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: _getTextStyle(context, 14)), //
                Text(
                  description,
                  style: _getTextStyle(context, 10),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  UtilFormat.toMoney(amount * (operation == 1 ? 1 : -1)),
                  style: _getTextStyle(context, 14),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
