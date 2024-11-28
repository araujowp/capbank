import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final double size;
  final VoidCallback onPressed;

  const PlusButton(
      {super.key, //
      required this.size, //
      required this.onPressed //
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: size,
        width: size,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: Colors.yellow,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
