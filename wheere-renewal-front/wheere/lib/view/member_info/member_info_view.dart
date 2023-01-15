import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/member_info_view_model.dart';

class MemberInfoView extends StatefulWidget {
  final MemberInfoViewModel userInfoViewModel;

  const MemberInfoView({Key? key, required this.userInfoViewModel})
      : super(key: key);

  @override
  State<MemberInfoView> createState() => _MemberInfoViewState();
}

class _MemberInfoViewState extends State<MemberInfoView> {
  late final _userInfoViewModel = widget.userInfoViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColor.backgroundMainColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "마이 페이지",
                    style: kTextMainStyleLarge,
                  ),
                  const Spacer(),
                  EditIconButton(
                    onPressed: _userInfoViewModel.navigateToMemberInfoEditPage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: kPaddingLargeSize),
            MemberInfo(
              name: _userInfoViewModel.member?.mName ?? "mName",
              sex: _userInfoViewModel.member?.mSex ?? "mSex",
              birthdate: _userInfoViewModel.member?.mBrithDate ?? "mBirthDate",
              phoneNumber: _userInfoViewModel.member?.mNum ?? "mNum",
            )
          ],
        ),
      ),
    );
  }
}
