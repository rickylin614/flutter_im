import 'package:flutter/material.dart';

class DialogUtils {
  static void showSuccessDialog(BuildContext context, String title,
      String message, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: onPressed,
              child: const Text('OK'), // 使用传入的回调
            ),
          ],
        );
      },
    );
  }

  static void showAlertDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              const Icon(Icons.warning, color: Colors.orange),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
