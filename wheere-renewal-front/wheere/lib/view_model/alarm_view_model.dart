import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/services.dart';
import 'package:wheere/view/common/commons.dart';

class AlarmViewModel extends ChangeNotifier {
  final AlarmService _alarmService = AlarmService();

  late AlarmListDTO _alarmListDTO;

  late List<Alarm> todayAlarms;
  late List<Alarm> thisWeekAlarms;
  late List<Alarm> lastAlarms;

  AlarmViewModel() {
    getAlarms();
  }

  void getAlarms() {
    _getTodayAlarms();
    _getThisWeekAlarms();
    _getLastAlarms();
  }

  void _getTodayAlarms() {
    todayAlarms  = [
      const Alarm(
        labelText: "labelText",
        prefixIcon: Icons.star,
        contents: "2023년 01월 06일 (금) 오후 10시 30분\n(금오공대 → 구미역)",
        aTime: "aTime",
        isNewAlarm: true,
      ),
      const Alarm(
        labelText: "labelText",
        prefixIcon: Icons.star,
        contents: "2023년 01월 06일 (금) 오후 10시 30분\n(금오공대 → 구미역)",
        aTime: "aTime",
        isNewAlarm: true,
      ),
      const Alarm(
        labelText: "labelText",
        prefixIcon: Icons.star,
        contents: "2023년 01월 06일 (금) 오후 10시 30분\n(금오공대 → 구미역)",
        aTime: "aTime",
        isNewAlarm: true,
      ),
    ];
  }

  void _getThisWeekAlarms() {
    thisWeekAlarms = [
      const Alarm(
        labelText: "labelText",
        prefixIcon: Icons.star,
        contents: "2023년 01월 06일 (금) 오후 10시 30분\n(금오공대 → 구미역)",
        aTime: "aTime",
        isNewAlarm: true,
      ),
      const Alarm(
        labelText: "labelText",
        prefixIcon: Icons.star,
        contents: "2023년 01월 06일 (금) 오후 10시 30분\n(금오공대 → 구미역)",
        aTime: "aTime",
        isNewAlarm: true,
      ),
      const Alarm(
        labelText: "labelText",
        prefixIcon: Icons.star,
        contents: "2023년 01월 06일 (금) 오후 10시 30분\n(금오공대 → 구미역)",
        aTime: "aTime",
        isNewAlarm: true,
      ),
    ];
  }

  void _getLastAlarms() {
    lastAlarms = [
      const Alarm(
        labelText: "labelText",
        prefixIcon: Icons.star,
        contents: "2023년 01월 06일 (금) 오후 10시 30분\n(금오공대 → 구미역)",
        aTime: "aTime",
        isNewAlarm: true,
      ),
      const Alarm(
        labelText: "labelText",
        prefixIcon: Icons.star,
        contents: "2023년 01월 06일 (금) 오후 10시 30분\n(금오공대 → 구미역)",
        aTime: "aTime",
        isNewAlarm: true,
      ),
      const Alarm(
        labelText: "labelText",
        prefixIcon: Icons.star,
        contents: "2023년 01월 06일 (금) 오후 10시 30분\n(금오공대 → 구미역)",
        aTime: "aTime",
        isNewAlarm: true,
      ),
    ];
  }

  void navigatePop() {}
}
