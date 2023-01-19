import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'member_info_item.dart';

class MemberInfo extends StatelessWidget {
  final String name;
  final String sex;
  final String birthdate;
  final String phoneNumber;

  const MemberInfo({
    Key? key,
    required this.name,
    required this.sex,
    required this.birthdate,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kPaddingLargeSize,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColor.backGroundSubColor,
          borderRadius: BorderRadius.circular(kBorderRadiusSize),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMiddleSize),
          child: Column(
            children: [
              MemberInfoItem(
                prefixIcon: Icons.person,
                title: "이름",
                contents: name,
              ),
              MemberInfoItem(
                prefixIcon: Icons.face,
                title: "성별",
                contents: sex,
              ),
              MemberInfoItem(
                prefixIcon: Icons.date_range,
                title: "생년월일",
                contents: birthdate,
              ),
              MemberInfoItem(
                prefixIcon: Icons.call,
                title: "전화번호",
                contents: phoneNumber,
              ),
              const SizedBox(height: kPaddingMiddleSize),
            ],
          ),
        ),
      ),
    );
  }
}
