import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      webBgColor: '#F44336',
      backgroundColor: Colors.red,
      webPosition: 'center',
      textColor: Colors.white,
      webShowClose: true,
    );
  }
}
