import 'package:capbank/components/date_navigation.dart';
import 'package:capbank/util/util_format.dart';
import 'package:flutter/material.dart';

class AmountDisplay extends StatelessWidget {
  final double amount;
  final DateTime date;
  final VoidCallback forWard;
  final VoidCallback backWard;
  const AmountDisplay(
      {super.key, //
      required this.amount, //
      required this.date,
      required this.forWard, //
      required this.backWard //
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
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
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              DateNavigation(date: date, forWard: forWard, backWard: backWard)
            ],
          ),
        ),
      ),
    );
  }
}
