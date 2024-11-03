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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(amount.toStringAsFixed(2)),
                  Text(date),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
