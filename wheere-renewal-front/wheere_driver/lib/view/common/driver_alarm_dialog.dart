import 'package:flutter/material.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'package:wheere_driver/view/common/commons.dart';

class DriverAlarmDialog extends StatelessWidget {
  final String title;
  final String content;

  const DriverAlarmDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BackIconButton(
            onPressed: () => Navigator.pop(context, false),
          ),
          const SizedBox(width: kPaddingMiddleSize),
          Text(
            title,
            style: kTextMainStyleLarge,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MemberInfo(
            name: "name",
            sex: "sex",
            birthdate: "birthdate",
            phoneNumber: "phoneNumber",
          ),
          Text(
            content,
            style: kTextMainStyleMiddle,
          ),
        ],
      ),
      actions: [
        CustomOutlinedMiniButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          text: "아니오",
        ),
        CustomOutlinedMiniButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          text: "예",
        ),
      ],
    );
  }
}
