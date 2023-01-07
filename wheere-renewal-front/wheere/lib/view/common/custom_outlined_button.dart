import 'package:flutter/material.dart';
import 'package:wheere/styles/text_styles.dart';

import '../../styles/border_radius.dart';
import '../../styles/colors.dart';

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
          backgroundColor: CustomColor.itemSubColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(kBorderRadius)),
          minimumSize: const Size.fromHeight(50),
          side: BorderSide.none),
      child: Text(
        text,
        style: kTextReverseStyleMiddle,
      ),
    );
  }
}
