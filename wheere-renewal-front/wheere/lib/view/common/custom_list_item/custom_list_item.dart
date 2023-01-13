import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'custom_list_item_text.dart';

class CustomListItem extends StatelessWidget {
  final String bNo;
  final String sStation;
  final String eStation;
  final String leftSeats;

  const CustomListItem({
    Key? key,
    required this.bNo,
    required this.sStation,
    required this.eStation,
    required this.leftSeats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: kPaddingMiddleSize),
        SizedBox(
          width: kOutlinedButtonSize.height,
          child: CustomListItemText(text: bNo),
        ),
        const SizedBox(width: kPaddingMiddleSize),
        Expanded(child: CustomListItemText(text: sStation)),
        const SizedBox(width: kPaddingMiddleSize),
        Expanded(child: CustomListItemText(text: eStation)),
        const SizedBox(width: kPaddingMiddleSize),
        SizedBox(
          width: kOutlinedButtonSize.height,
          child: CustomListItemText(text: leftSeats),
        ),
        const SizedBox(width: kPaddingMiddleSize),
      ],
    );
  }
}