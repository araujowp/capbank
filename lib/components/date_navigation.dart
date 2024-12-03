import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateNavigation extends StatelessWidget {
  final DateTime date;
  final VoidCallback forWard;
  final VoidCallback backWard;

  const DateNavigation(
      {super.key,
      required this.date, //
      required this.forWard, //
      required this.backWard //
      });

  Color? _getColor(BuildContext context) {
    return Theme.of(context).textTheme.titleSmall!.color;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: 'backWard',
          onPressed: backWard, //
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: _getColor(context),
          ), //
        ),
        Text(
          DateFormat('dd/MM/yyyy').format(date),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 20),
        ),
        FloatingActionButton(
          heroTag: 'forWard',
          onPressed: forWard, //
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(
            Icons.arrow_forward_ios_sharp,
            color: _getColor(context),
          ), //
        ),
      ],
    );
  }
}
