import 'package:flutter/material.dart';
import 'package:wheere_driver/model/dto/alarm_dto/alarm_member_dto.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'package:wheere_driver/view/common/commons.dart';

class RideMemberDialog extends StatelessWidget {
  final AlarmMemberDTO alarmMemberDTO;

  const RideMemberDialog({
    Key? key,
    required this.alarmMemberDTO,
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
            name: alarmMemberDTO.mName,
            sex: alarmMemberDTO.mSex,
            birthdate: alarmMemberDTO.mBirthDate,
            phoneNumber: alarmMemberDTO.mNum,
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
