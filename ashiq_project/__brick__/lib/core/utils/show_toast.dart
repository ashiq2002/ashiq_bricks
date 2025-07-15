import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

Future<void> showToast({required String message, bool isError = true}) async {
  await Fluttertoast.cancel(); // Cancel any existing toast
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: isError ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
