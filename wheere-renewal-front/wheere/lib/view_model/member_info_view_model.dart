import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';

import 'type/types.dart';

class MemberInfoViewModel extends ChangeNotifier {
  MemberDTO? get member => _member.member;
  late Member _member;

  MemberInfoViewModel() {
    _member = Member();
  }

  void navigateToMemberInfoEditPage() {}
}
