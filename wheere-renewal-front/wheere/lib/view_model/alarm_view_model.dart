import 'package:flutter/material.dart';
import 'package:wheere/model/dto/alarm_dto/test_alarm_dto.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/services.dart';
import 'package:wheere/util/utils.dart';
import 'package:wheere/view/common/commons.dart';

class AlarmViewModel extends ChangeNotifier {
  final AlarmService _alarmService = AlarmService();

  late List<BaseAlarmDTO> _alarmList;

  List<Alarm> todayAlarms = [];
  List<Alarm> thisWeekAlarms = [];
  List<Alarm> lastAlarms = [];

  AlarmViewModel() {
    getAlarms();
  }

  Future getAlarms() async {
    await _alarmService.getAlarmWithLocal().then((e) {
      _alarmList = e.alarms;
    });
    for (var element in _alarmList) {
      if (DateTime.parse(element.aTime).compareTo(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          )) >
          0) {
        Alarm? alarm = _classifyAlarms(element);
        if (alarm != null) {
          todayAlarms.add(alarm);
        }
      } else if (DateTime.parse(element.aTime).compareTo(DateTime(
              DateTime.now().subtract(const Duration(days: 7)).year,
              DateTime.now().subtract(const Duration(days: 7)).month,
              DateTime.now().subtract(const Duration(days: 7)).day)) >
          0) {
        Alarm? alarm = _classifyAlarms(element);
        if (alarm != null) {
          thisWeekAlarms.add(alarm);
        }
      } else {
        Alarm? alarm = _classifyAlarms(element);
        if (alarm != null) {
          lastAlarms.add(alarm);
        }
      }
    }
    notifyListeners();
  }

  Alarm? _classifyAlarms(BaseAlarmDTO element) {
    switch (element.alarmType) {
      case "rating":
        element = element as RatingAlarmDTO;
        AlarmReservationDTO? reservation =
            element.reservation; //_member.reservationMap[element.rId];
        return Alarm(
          labelText: element.title,
          prefixIcon: Icons.star,
          contents:
              "${reservation.rDate} ${reservation.sTime}\n(${reservation.sStationName} → ${reservation.eStationName})",
          aTime: dateFormat.format(DateTime.parse(element.aTime)),
          isNewAlarm: false,
        );
      default:
        element = element as TestAlarmDTO;
        return Alarm(
          labelText: element.title,
          prefixIcon: Icons.add,
          contents: element.data,
          aTime: element.aTime,
          isNewAlarm: false,
        );
    }
  }

  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
