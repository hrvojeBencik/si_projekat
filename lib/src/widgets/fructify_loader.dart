import 'package:flutter/material.dart';
import 'package:si_app/src/constants/colors.dart';

class FructifyLoader extends StatelessWidget {
  const FructifyLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: FructifyColors.lightGreen,
      ),
    );
  }
}
