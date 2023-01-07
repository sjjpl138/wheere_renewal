import 'package:flutter/material.dart';
import 'package:wheere/styles/text_styles.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;

  final String text;

  const CustomTextButton({Key? key, this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          minimumSize: const Size.fromHeight(14),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          text,
          style: kTextMainStyleSmall,
        ));
  }
}
