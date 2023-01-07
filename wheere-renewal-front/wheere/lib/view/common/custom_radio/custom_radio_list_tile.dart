import 'package:flutter/material.dart';
import 'package:wheere/styles/screens.dart';
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
      height: const Size.fromHeight(50).height,
      decoration: BoxDecoration(
          color: CustomColor.textFormMainColor,
          borderRadius: BorderRadius.circular(kBorderRadius)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: kTextMainStyleMiddle,
            ),
          ),
          const Spacer(),
          CustomRadioButton<T>(value: value, groupValue: groupValue, onChanged: onChanged),
        ],
      ),
    );
  }
}
