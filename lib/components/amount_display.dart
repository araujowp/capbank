import 'package:capbank/util/util_format.dart';
import 'package:flutter/material.dart';

class AmountDisplay extends StatelessWidget {
  final double amount;
  final String date;

  const AmountDisplay(
      {super.key, //
      required this.amount, //
      required this.date //
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                UtilFormat.toMoney(amount),
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Adlam Display',
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(date),
            ],
          ),
        ),
      ),
    );
  }
}
