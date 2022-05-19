import 'package:flutter/material.dart';

class FructifyStyles {
  static final FructifyTextStyles textStyle = FructifyTextStyles();
}

class FructifyTextStyles {
  final TextStyle headerStyle1 = const TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );

  final TextStyle headerStyle2 = const TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );

  final TextStyle headerStyle3 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  final TextStyle errorMessageStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.red,
  );
}
