import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static customSnackbar(BuildContext context, int duration, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: duration),
      content: Text("$message"),
    ));
  }
}
