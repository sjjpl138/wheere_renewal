import 'package:flutter/material.dart';
import 'package:wheere/view/search/search_page.dart';

class MainViewModel extends ChangeNotifier {
  bool isNewAlarm = true;

  final List<Widget> tabs = const [
    Tab(text: "예약하기"),
    Tab(text: "예약확인"),
    Tab(text: "마이페이지"),
  ];

  final List<Widget> tabItems = [
    const SearchPage(),
    Container(),
    Container(),
  ];
}
