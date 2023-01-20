import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wheere/model/service/services.dart';
import 'package:wheere/view/alarm/alarm_page.dart';
import 'package:wheere/view/check/check_page.dart';
import 'package:wheere/view/search/search_page.dart';
import 'package:wheere/view/member_info/member_info_page.dart';

class MainViewModel extends ChangeNotifier {
  bool hasNewAlarm = false;
  final AlarmService _alarmService = AlarmService();

  MainViewModel() {
    _getHasNewAlarm();
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _getHasNewAlarm();
    });
  }

  Future _getHasNewAlarm() async {
    await _alarmService
        .getHasNewAlarmWithLocal()
        .then((value) => hasNewAlarm = value.hasNewAlarm);
    notifyListeners();
  }

  final Map<Widget, Widget> tabs = {
    const Tab(text: "예약하기"): const SearchPage(),
    const Tab(text: "예약확인"): const CheckPage(),
    const Tab(text: "마이페이지"): const MemberInfoPage(),
  };

  void navigateToAlarmPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AlarmPage()),
    ).then((value) => _getHasNewAlarm());
  }
}
