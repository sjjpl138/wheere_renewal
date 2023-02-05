import 'package:flutter/material.dart';
import 'package:wheere_driver/model/dto/dtos.dart';
import 'package:wheere_driver/styles/styles.dart';
import 'package:wheere_driver/view/common/commons.dart';

class MembersDialog extends StatelessWidget {
  final BusStationInfo busStationInfo;
  final void Function(MemberDTO memberDTO) showRideMemberDialog;
  final void Function(MemberDTO memberDTO) showQuitMemberDialog;

  const MembersDialog({
    Key? key,
    required this.busStationInfo,
    required this.showRideMemberDialog,
    required this.showQuitMemberDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          BackIconButton(onPressed: () => Navigator.pop(context)),
          const Text(
            "목록",
            style: kTextMainStyleLarge,
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("탑승자", style: kTextMainStyleLarge,),
            const SizedBox(height: kPaddingMiddleSize,),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: kPaddingMiddleSize),
              itemCount: busStationInfo.ridePeople.length,
              itemBuilder: (BuildContext context, int index) =>
                  CustomOutlinedButton(
                onPressed: () =>
                    showRideMemberDialog(busStationInfo.ridePeople[index]),
                text: busStationInfo.ridePeople[index].mName,
              ),
            ),
            const Text("하차자", style: kTextMainStyleLarge,),
            const SizedBox(height: kPaddingMiddleSize,),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(bottom: kPaddingMiddleSize),
              itemCount: busStationInfo.quitPeople.length,
              itemBuilder: (BuildContext context, int index) =>
                  CustomOutlinedButton(
                onPressed: () =>
                    showQuitMemberDialog(busStationInfo.quitPeople[index]),
                text: busStationInfo.quitPeople[index].mName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
