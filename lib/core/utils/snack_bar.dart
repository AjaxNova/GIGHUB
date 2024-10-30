import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    ScaffoldMessengerState scaffoldMessenger,
    String message,
    Color bgColor,
    Color textColor,
    TextStyle textStyle) {
  return scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: textStyle,
      ),
      backgroundColor: bgColor,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: textColor,
        onPressed: () {
          scaffoldMessenger.hideCurrentSnackBar();
        },
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
