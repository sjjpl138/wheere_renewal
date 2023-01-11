import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class CustomDialogButton extends StatelessWidget {
  final void Function()? onPressed;

  final String? labelText;
  final String? text;

  final IconData? prefixIcon;

  const CustomDialogButton({
    Key? key,
    required this.onPressed,
    required this.labelText,
    required this.text,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: CustomColor.backGroundSubColor,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        minimumSize: kContainerSize,
        side: BorderSide.none,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(kPaddingSmallSize),
                child: Icon(
                  prefixIcon,
                  size: kIconSubSize,
                  color: CustomColor.itemSubColor,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kPaddingSmallSize),
                child: Text(
                  labelText ?? "",
                  style: kTextMainStyleSmall,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: kPaddingSmallSize,
              bottom: kPaddingSmallSize,
            ),
            child: Text(
              text ?? "",
              style: kTextMainStyleMiddle,
            ),
          ),
        ],
      ),
    );
  }
}
