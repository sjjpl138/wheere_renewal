import 'package:flutter/material.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'package:wheere_driver/view/common/commons.dart';

class QuitMemberDialog extends StatelessWidget {
  final MemberDTO alarmMemberDTO;

  const QuitMemberDialog({
    Key? key,
    required this.alarmMemberDTO,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "하차자 정보",
        style: kTextMainStyleLarge,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MemberInfo(
            name: alarmMemberDTO.mName,
            sex: alarmMemberDTO.mSex,
            birthdate: alarmMemberDTO.mBirthDate,
            phoneNumber: alarmMemberDTO.mNum,
          ),
          const Text(
            "하차자를 확인하였습니까?",
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
