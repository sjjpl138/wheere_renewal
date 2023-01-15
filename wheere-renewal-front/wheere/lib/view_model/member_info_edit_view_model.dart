import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';

import 'type/types.dart';

class MemberInfoEditViewModel extends ChangeNotifier {
  MemberDTO? get member => _member.member;
  late Member _member;

  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;

  late final String sex;
  late final String birthDate;

  final editKey = GlobalKey<FormState>();

  MemberInfoEditViewModel() {
    _member = Member();
    nameController = TextEditingController(text: _member.member?.mName ?? "");
    phoneNumberController =
        TextEditingController(text: _member.member?.mNum ?? "");
    sex = _member.member?.mSex ?? "";
    birthDate = _member.member?.mBrithDate ?? "";
  }

  Future editMemberInfo() async {
    if (editKey.currentState!.validate()) {
      notifyListeners();
    }
  }

  void navigatePop() {}
}
