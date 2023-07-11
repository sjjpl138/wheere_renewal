import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;

  final Color color;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = CustomColor.buttonMainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        minimumSize: kOutlinedButtonSize,
        side: BorderSide.none,
      ),
      child: Text(
        text,
        style: kTextReverseStyleMiddle,
      ),
    );
  }
}
