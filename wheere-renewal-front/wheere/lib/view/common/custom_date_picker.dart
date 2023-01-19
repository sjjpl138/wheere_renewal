import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';

class CustomDatePicker extends StatelessWidget {
  final void Function(DateTime) onDateTimeChanged;
  final DateTime initDate;

  const CustomDatePicker({
    Key? key,
    required this.onDateTimeChanged,
    required this.initDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.backGroundSubColor,
        borderRadius: BorderRadius.circular(kBorderRadiusSize),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  kPaddingMiddleSize,
                  kPaddingMiddleSize,
                  kPaddingMiddleSize,
                  0.0,
                ),
                child: Icon(
                  Icons.date_range,
                  size: kIconMiddleSize,
                  color: CustomColor.itemSubColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: kPaddingMiddleSize),
                child: Text(
                  "생년월일",
                  style: kTextMainStyleSmall,
                ),
              ),
            ],
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: kOutlinedButtonSize.height,
            ),
            color: CustomColor.backGroundSubColor,
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: kTextMainStyleMiddle,
                ),
              ),
              child: CupertinoDatePicker(
                minimumYear: 1900,
                maximumYear: DateTime.now().year,
                initialDateTime: initDate,
                maximumDate: DateTime.now(),
                onDateTimeChanged: onDateTimeChanged,
                mode: CupertinoDatePickerMode.date,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
