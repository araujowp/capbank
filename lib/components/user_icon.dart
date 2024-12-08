import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  final String picture;
  const UserIcon(
    this.picture, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: AssetImage(picture),
      ),
    );
  }
}
