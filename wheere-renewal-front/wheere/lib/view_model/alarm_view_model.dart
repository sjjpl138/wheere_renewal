import 'package:flutter/material.dart';
import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/service/services.dart';
import 'package:wheere/util/utils.dart';
import 'package:wheere/view/common/commons.dart';

class AlarmViewModel extends ChangeNotifier {
  final AlarmService _alarmService = AlarmService();

  late List<AlarmDTO> _alarmList;

  List<Alarm> todayAlarms = [];
  List<Alarm> thisWeekAlarms = [];
  List<Alarm> lastAlarms = [];

  AlarmViewModel() {
    getAlarms();
  }

  Future getAlarms() async {
//    await _member.getReservationList();
/*    await _member.logout();
    await _alarmService.addAlarmWithLocal(
      AlarmDTO(
        alarmType: "rating",
        aTime: "2022-12-31 11:00",
        reservation: ReservationDTO(
          rId: 3,
          routeId: "routeId",
          bNo: "bNo",
          rDate: "2022-12-31",
          sStationId: 3,
          sStationName: "sStationName",
          sTime: "sTime",
          eStationId: 1,
          eStationName: "eStationName",
          eTime: "eTime",
          rState: "rState",
          vNo: "vNo",
        ),
      ),
    );
    await _alarmService.addAlarmWithLocal(
      AlarmDTO(
        alarmType: "rating",
        aTime: "2023-01-01 11:00",
        reservation: ReservationDTO(
          rId: 5,
          routeId: "routeId",
          bNo: "bNo",
          rDate: "2023-01-01",
          sStationId: 3,
          sStationName: "sStationName",
          sTime: "sTime",
          eStationId: 1,
          eStationName: "eStationName",
          eTime: "eTime",
          rState: "rState",
          vNo: "vNo",
        ),
      ),
    );
    await _alarmService.addAlarmWithLocal(
      AlarmDTO(
        alarmType: "rating",
        aTime: "2023-01-13 11:00",
        reservation: ReservationDTO(
          rId: 2,
          routeId: "routeId",
          bNo: "bNo",
          rDate: "2023-01-13",
          sStationId: 2,
          sStationName: "sStationName",
          sTime: "sTime",
          eStationId: 1,
          eStationName: "eStationName",
          eTime: "eTime",
          rState: "rState",
          vNo: "vNo",
        ),
      ),
    );
    await _alarmService.addAlarmWithLocal(
      AlarmDTO(
        alarmType: "rating",
        aTime: "2023-01-17 15:00",
        reservation: ReservationDTO(
          rId: 4,
          routeId: "routeId",
          bNo: "bNo",
          rDate: "2023-01-17",
          sStationId: 4,
          sStationName: "sStationName",
          sTime: "sTime",
          eStationId: 1,
          eStationName: "eStationName",
          eTime: "eTime",
          rState: "rState",
          vNo: "vNo",
        ),
      ),
    );
    await _alarmService.addAlarmWithLocal(
      AlarmDTO(
        alarmType: "rating",
        aTime: "2023-01-18 07:00",
        reservation: ReservationDTO(
          rId: 1,
          routeId: "routeId",
          bNo: "bNo",
          vNo: "vNo",
          rDate: "2023-01-18",
          sStationId: 1,
          sStationName: "sStationName",
          sTime: "sTime",
          eStationId: 1,
          eStationName: "eStationName",
          eTime: "eTime",
          rState: "rState"
        ),
      ),
    );*/
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

  Alarm? _classifyAlarms(AlarmDTO element) {
    switch (element.alarmType) {
      case "rating":
        AlramReservationDTO? reservation =
            element.reservation; //_member.reservationMap[element.rId];
        return Alarm(
          labelText: "평점 작성 요청",
          prefixIcon: Icons.star,
          contents:
              "${reservation.rDate} ${reservation.sTime}\n(${reservation.sStationName} → ${reservation.eStationName})",
          aTime: dateFormat.format(DateTime.parse(element.aTime)),
          isNewAlarm: false,
        );
      default:
        return null;
    }
  }

  void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
