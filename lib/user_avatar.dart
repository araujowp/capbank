import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final int id;
  final String name;
  final String photo;
  final VoidCallback? onTap;

  const UserAvatar({
    Key? key,
    required this.id,
    required this.name,
    required this.photo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(photo),
                ),
                const SizedBox(width: 10),
                Text(name, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
