import 'package:flutter/material.dart';
import 'package:si_app/src/constants/colors.dart';

class FructifyLoader extends StatelessWidget {
  const FructifyLoader({Key? key, this.isVertical = false}) : super(key: key);
  const FructifyLoader.vertical({Key? key, this.isVertical = true}) : super(key: key);

  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isVertical
          ? const LinearProgressIndicator(
              color: FructifyColors.lightGreen,
              backgroundColor: FructifyColors.whiteGreen,
            )
          : const CircularProgressIndicator(
              color: FructifyColors.lightGreen,
            ),
    );
  }
}
