import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/util/utils.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/member_info_view_model.dart';

class MemberInfoView extends StatefulWidget {
  final MemberInfoViewModel userInfoViewModel;

  const MemberInfoView({Key? key, required this.userInfoViewModel})
      : super(key: key);

  @override
  State<MemberInfoView> createState() => _MemberInfoViewState();
}

class _MemberInfoViewState extends State<MemberInfoView>
    with AutomaticKeepAliveClientMixin {
  late final _userInfoViewModel = widget.userInfoViewModel;

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
                    onPressed: () => _userInfoViewModel
                        .navigateToMemberInfoEditPage(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kPaddingLargeSize),
            MemberInfo(
              name: _userInfoViewModel.member?.mName ?? "mName",
              sex: _userInfoViewModel.member?.mSex ?? "남성",
              birthdate: _userInfoViewModel.member?.mBirthDate ??
                  birthDateFormat.format(DateTime.now()),
              phoneNumber: _userInfoViewModel.member?.mNum ?? "01000000000",
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
