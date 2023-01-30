import 'package:wheere/model/dto/alarm_dto/rating_alarm_dto.dart';
import 'package:wheere/model/dto/alarm_dto/test_alarm_dto.dart';

abstract class BaseAlarmDTO {
  String title = "";
  String body = "";
  String alarmType = "";
  String aTime = "";
  Map<String, dynamic> toJson();

  factory BaseAlarmDTO.fromJson(Map<String, dynamic> json) {
    switch(json['alarmType']) {
      case "rating":
        return RatingAlarmDTO.fromJson(json);
      default:
        return TestAlarmDTO.fromJson(json);
    }
  }
}