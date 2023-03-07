import 'package:wheere_driver/model/dto/alarm_dto/canceled_reservation_alarm_dto.dart';
import 'new_reservation_alarm_dto.dart';
import 'test_alarm_dto.dart';

abstract class BaseAlarmDTO {
  String title = "";
  String body = "";
  String alarmType = "";
  String aTime = "";
  Map<String, dynamic> toJson();

  factory BaseAlarmDTO.fromJson(Map<String, dynamic> json) {
    switch(json['alarmType']) {
      case "newReservation":
        return NewReservationAlarmDTO.fromJson(json);
      case "cancelReservation":
        return CanceledReservationAlarmDTO.fromJson(json);
      default:
        return TestAlarmDTO.fromJson(json);
    }
  }
}