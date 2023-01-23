import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/util/utils.dart';
import 'type/types.dart';

class MemberInfoEditViewModel extends ChangeNotifier {
  MemberDTO? get member => _member.member;
  late Member _member;

  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;

  late String sex;
  late String birthDate;

  final editKey = GlobalKey<FormState>();

  MemberInfoEditViewModel() {
    _member = Member();
    nameController = TextEditingController(text: _member.member!.mName);
    phoneNumberController = TextEditingController(text: _member.member!.mNum);
    sex = _member.member!.mSex;
    birthDate = _member.member!.mBirthDate;
  }

  Future editMemberInfo(BuildContext context) async {
    if (editKey.currentState!.validate()) {
      await _member
          .updateInfo(
            MemberInfoDTO(
              mId: member!.mId,
              mName: nameController.text,
              mSex: sex,
              mBirthDate: birthDate,
              mNum: phoneNumberController.text,
            ),
          )
          .then(
            (value) => {
              notifyListeners(),
              Navigator.pop(context),
            },
          );
    }
  }

  void onSexChanged(String value) {
    sex = value;
    notifyListeners();
  }

  void onBirthDateChanged(DateTime value) {
    birthDate = birthDateFormat.format(value);
    notifyListeners();
  }

  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
