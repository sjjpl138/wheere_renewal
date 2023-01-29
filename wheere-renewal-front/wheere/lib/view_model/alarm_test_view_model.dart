import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/alarm_test_service.dart';
import 'package:wheere/model/service/services.dart';
import 'package:wheere/util/utils.dart';
import 'package:wheere/view/common/commons.dart';

class AlarmTestViewModel extends ChangeNotifier {
  final AlarmTestService _alarmService = AlarmTestService();

  late List<String> _alarmList;

  List<Alarm> todayAlarms = [];
  List<Alarm> thisWeekAlarms = [];
  List<Alarm> lastAlarms = [];

  AlarmTestViewModel() {
    getAlarms();
  }

  Future getAlarms() async {
    await _alarmService.getAlarmWithLocal().then((e) {
      _alarmList = e.alarms;
    });
    for (var element in _alarmList) {
      Alarm? alarm = _classifyAlarms(element);
      if (alarm != null) {
        todayAlarms.add(alarm);
      }
    }
    notifyListeners();
  }

  Alarm? _classifyAlarms(String element) {
    return Alarm(
      labelText: "테스트 알림",
      prefixIcon: Icons.star,
      contents: element,
      aTime: "",
      isNewAlarm: false,
    );
  }

  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
