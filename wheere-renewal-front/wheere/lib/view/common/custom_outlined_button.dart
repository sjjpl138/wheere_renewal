import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;

  const CustomOutlinedButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: CustomColor.buttonMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        minimumSize: kContainerSize,
        side: BorderSide.none,
      ),
      child: Text(
        text,
        style: kTextReverseStyleMiddle,
      ),
    );
  }
}
