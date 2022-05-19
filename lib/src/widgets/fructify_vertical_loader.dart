import 'package:flutter/material.dart';
import 'package:si_app/src/constants/styles.dart';
import 'package:si_app/src/widgets/fructify_loader.dart';

class FructifyVerticalLoader extends StatelessWidget {
  const FructifyVerticalLoader({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: FructifyStyles.textStyle.headerStyle3),
        const SizedBox(height: 20),
        const SizedBox(width: 300, child: FructifyLoader.vertical()),
      ],
    );
  }
}
