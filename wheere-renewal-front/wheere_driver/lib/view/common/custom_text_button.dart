import 'package:flutter/material.dart';
import 'package:wheere_driver/styles/styles.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;

  const CustomTextButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          minimumSize: kTextButtonSize,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          text,
          style: kTextMainStyleSmall,
        ));
  }
}
