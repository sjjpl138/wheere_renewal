import 'package:flutter/material.dart';
import 'package:wheere/view/member_info/member_info_edit_page.dart';

class MemberInfoViewModel extends ChangeNotifier {
  void navigateToMemberInfoEditPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MemberInfoEditPage()),
    );
  }
}
