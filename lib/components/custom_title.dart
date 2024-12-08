import 'package:capbank/components/user_icon.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final String picture;

  const CustomTitle(
    this.title,
    this.picture, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserIcon(picture),
        Flexible(child: Text(title)),
      ],
    );
  }
}
