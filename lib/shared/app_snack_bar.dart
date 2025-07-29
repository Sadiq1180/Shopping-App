import 'package:flutter/material.dart';
import 'package:shopping_app/shared/navigation/navigator_key.dart';

class AppSnackBar {
  static showSnackBar(String message, {BuildContext? context}) {
    closeSnackBar();
    ScaffoldMessenger.of(context ?? appContext).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }

  static closeSnackBar() {
    ScaffoldMessenger.of(appContext).removeCurrentSnackBar();
  }
}
