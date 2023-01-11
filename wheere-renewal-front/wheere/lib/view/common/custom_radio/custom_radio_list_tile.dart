import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/custom_radio/custom_radio_button.dart';

class CustomRadioListTitle<T> extends StatelessWidget {
  final T? value;
  final T? groupValue;

  final String title;

  final void Function(T?)? onChanged;

  const CustomRadioListTitle(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.title,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kContainerSize.height,
      decoration: BoxDecoration(
        color: CustomColor.backGroundSubColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
            child: Text(
              title,
              style: kTextMainStyleMiddle,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kPaddingLargeSize),
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
