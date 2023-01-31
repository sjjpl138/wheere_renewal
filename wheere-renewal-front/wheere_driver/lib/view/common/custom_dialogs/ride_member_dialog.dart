import 'package:flutter/material.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'package:wheere_driver/view/common/commons.dart';

class RideMemberDialog extends StatelessWidget {
  final MemberDTO memberDTO;

  const RideMemberDialog({
    Key? key,
    required this.memberDTO,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "탑승자 정보",
        style: kTextMainStyleLarge,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MemberInfo(
            name: memberDTO.mName,
            sex: memberDTO.mSex,
            birthdate: memberDTO.mBirthDate,
            phoneNumber: memberDTO.mNum,
          ),
          const Text(
            "탑승자를 확인하였습니까?",
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
