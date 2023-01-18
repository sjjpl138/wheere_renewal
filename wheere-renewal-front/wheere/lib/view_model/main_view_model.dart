import 'package:flutter/material.dart';
import 'package:wheere/view/check/check_page.dart';
import 'package:wheere/view/search/search_page.dart';
import 'package:wheere/view/member_info/member_info_page.dart';

class MainViewModel extends ChangeNotifier {
  bool isNewAlarm = true;

  final Map<Widget, Widget> tabs = {
    const Tab(text: "예약하기") : const SearchPage(),
    const Tab(text: "예약확인") : const CheckPage(),
    const Tab(text: "마이페이지") : const MemberInfoPage(),
  };
}