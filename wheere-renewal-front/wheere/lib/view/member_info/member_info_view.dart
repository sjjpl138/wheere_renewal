import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/member_info_view_model.dart';
import 'package:wheere/view_model/type/types.dart';

class MemberInfoView extends StatefulWidget {
  final MemberInfoViewModel memberInfoViewModel;
  final Member member;

  const MemberInfoView({
    Key? key,
    required this.memberInfoViewModel,
    required this.member,
  }) : super(key: key);

  @override
  State<MemberInfoView> createState() => _MemberInfoViewState();
}

class _MemberInfoViewState extends State<MemberInfoView>
    with AutomaticKeepAliveClientMixin {
  late final _memberInfoViewModel = widget.memberInfoViewModel;
  late final _member = widget.member;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                    onPressed: () => _memberInfoViewModel
                        .navigateToMemberInfoEditPage(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kPaddingMiddleSize),
            MemberInfo(
              name: _member.member.mName,
              sex: _member.member.mSex,
              birthdate: _member.member.mBirthDate,
              phoneNumber: _member.member.mNum,
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
