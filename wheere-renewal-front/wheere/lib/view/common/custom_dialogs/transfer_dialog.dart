import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';

class TransferDialog extends StatelessWidget {
  const TransferDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        "환승 경로가 포함되었습니다\n계속하시겠습니까?",
        style: kTextMainStyleMiddle,
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
