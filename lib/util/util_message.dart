import 'package:flutter/material.dart';

class UtilMessage {
  void show(BuildContext context, String message,
      {MessageType messageType = MessageType.info}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            messageType == MessageType.error ? Colors.red : Colors.green,
      ),
    );
  }
}

enum MessageType {
  info,
  error,
}
