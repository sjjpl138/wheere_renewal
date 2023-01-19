import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view/member_info/member_info_edit_page.dart';

import 'type/types.dart';

class MemberInfoViewModel extends ChangeNotifier {
  MemberDTO? get member => _member.member;
  late Member _member;

  MemberInfoViewModel() {
    _member = Member();
  }

  void navigateToMemberInfoEditPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MemberInfoEditPage()),
    );
  }
}
