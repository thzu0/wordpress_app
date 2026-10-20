import 'package:flutter/material.dart';

class CustomDialogBox {
  static void showMessage(
    BuildContext context,
    String title,
    String massege,
    String buttonText,
    final VoidCallback onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(title, style: TextStyle(fontFamily: 'Lalezar')),
            content: Text(
              massege,
              style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: const TextStyle(fontFamily: 'Vazirmatn'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
