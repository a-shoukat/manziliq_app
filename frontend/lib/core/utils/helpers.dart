import 'package:flutter/material.dart';

void showSnack(BuildContext context, String message, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    ),
  );
}

String generateBookingRef() {
  return 'MQ-${DateTime.now().millisecondsSinceEpoch.toRadixString(36).toUpperCase()}';
}
