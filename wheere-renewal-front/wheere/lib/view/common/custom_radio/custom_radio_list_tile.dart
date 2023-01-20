import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/custom_radio/custom_radio_button.dart';

class CustomRadioListTitle<T> extends StatelessWidget {
  final T? value;
  final T? groupValue;

  final String title;

  final void Function(T?)? onChanged;

  final double contentsPadding;

  const CustomRadioListTitle({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
    this.contentsPadding = kPaddingLargeSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: contentsPadding == kPaddingLargeSize
          ? kOutlinedButtonSize.height
          : null,
      decoration: BoxDecoration(
        color: CustomColor.backGroundSubColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: contentsPadding),
            child: Text(
              title,
              style: kTextMainStyleMiddle,
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: contentsPadding),
            child: CustomRadioButton<T>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
