import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

class CustomOutlinedMiniButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;

  const CustomOutlinedMiniButton(
      {Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: CustomColor.buttonSubColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        minimumSize: kOutlinedSmallButtonSize,
        side: BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kPaddingSmallSize),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: kTextReverseStyleSmall,
        ),
      ),
    );
  }
}
