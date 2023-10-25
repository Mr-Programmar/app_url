import 'dart:io';

import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message,
      {required Color color}) {
    if (Platform.isIOS) {
      // Show iOS-style SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      // Show Android-style SnackBar (or default SnackBar for other platforms)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        elevation: 100,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Customize the border radius
        ),
      ));
    }
  }
}
