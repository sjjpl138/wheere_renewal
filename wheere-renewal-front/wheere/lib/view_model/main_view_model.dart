import 'package:flutter/material.dart';
import 'package:wheere/view/search/search_page.dart';

class MainViewModel extends ChangeNotifier {
  bool isNewAlarm = true;

  final Map<Widget, Widget> tabs = {
    const Tab(text: "예약하기") : const SearchPage(),
    const Tab(text: "예약확인") : Container(),
    const Tab(text: "마이페이지") : Container(),
  };
}
