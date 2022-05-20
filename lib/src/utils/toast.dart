import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:si_app/src/constants/colors.dart';

void displayToast({required String message, Color? color, Duration duration = const Duration(seconds: 5)}) {
  showToast(
    message,
    position: ToastPosition.bottom,
    backgroundColor: color ?? FructifyColors.lightGreen,
    textStyle: const TextStyle(
      color: FructifyColors.white,
    ),
    duration: duration,
  );
}
