import 'package:flutter/material.dart';
import 'package:wheere/styles/styles.dart';
import 'package:wheere/util/utils.dart';
import 'package:wheere/view/common/commons.dart';
import 'package:wheere/view_model/member_info_edit_view_model.dart';

class MemberInfoEditView extends StatefulWidget {
  final MemberInfoEditViewModel memberInfoEditViewModel;

  const MemberInfoEditView({Key? key, required this.memberInfoEditViewModel})
      : super(key: key);

  @override
  State<MemberInfoEditView> createState() => _MemberInfoEditViewState();
}

class _MemberInfoEditViewState extends State<MemberInfoEditView> {
  late final _memberInfoEditViewModel = widget.memberInfoEditViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        context,
        title: "마이 페이지",
        leading: BackIconButton(
          onPressed: _memberInfoEditViewModel.navigatePop,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingLargeSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: kPaddingLargeSize),
              const Text(
                "사용자 정보 수정",
                style: kTextMainStyleLarge,
              ),
              const SizedBox(height: kPaddingLargeSize),
              Form(
                key: _memberInfoEditViewModel.editKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: "이름",
                      hintText: "이름",
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.text,
                      validator: validateName,
                      controller: _memberInfoEditViewModel.nameController,
                    ),
                    const SizedBox(height: kPaddingLargeSize),
                    CustomDialogButton(
                      onPressed: null,
                      labelText: "성별",
                      text: _memberInfoEditViewModel.sex,
                      prefixIcon: Icons.face,
                    ),
                    const SizedBox(height: kPaddingLargeSize),
                    CustomDialogButton(
                      onPressed: null,
                      labelText: "생년월일",
                      text: _memberInfoEditViewModel.birthDate,
                      prefixIcon: Icons.date_range,
                    ),
                    const SizedBox(height: kPaddingLargeSize),
                    CustomTextFormField(
                      labelText: "전화번호",
                      hintText: "전화번호",
                      prefixIcon: Icons.call,
                      keyboardType: TextInputType.phone,
                      validator: validatePhoneNumber,
                      controller:
                          _memberInfoEditViewModel.phoneNumberController,
                    ),
                    const SizedBox(height: kPaddingLargeSize),
                    CustomOutlinedButton(
                      onPressed: () =>
                          _memberInfoEditViewModel.editMemberInfo(),
                      text: "수정하기",
                    ),
                    const SizedBox(height: kPaddingLargeSize),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
