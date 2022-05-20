import 'package:flutter/material.dart';
import 'package:si_app/src/constants/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: FructifyColors.lightGreen,
      ),
    );
  }
}
