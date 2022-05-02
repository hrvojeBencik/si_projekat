import 'package:flutter/material.dart';
import 'package:si_app/src/constants/colors.dart';

class FructifyButton extends StatefulWidget {
  const FructifyButton({
    Key? key,
    this.width,
    this.height,
    this.textStyle,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final String text;
  final Function()? onClick;

  @override
  State<FructifyButton> createState() => _FructifyButtonState();
}

class _FructifyButtonState extends State<FructifyButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 34, vertical: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200),
              side: isHovering
                  ? BorderSide.none
                  : const BorderSide(
                      color: FructifyColors.black,
                    ),
            ),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            isHovering ? FructifyColors.white : FructifyColors.black,
          ),
          overlayColor:
              MaterialStateProperty.all<Color>(FructifyColors.lightGreen),
          backgroundColor:
              MaterialStateProperty.all<Color>(FructifyColors.white),
        ),
        onPressed: widget.onClick,
        onHover: (value) {
          setState(() {
            isHovering = value;
          });
        },
        child: Text(
          widget.text,
          style: widget.textStyle ??
              const TextStyle(
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}
