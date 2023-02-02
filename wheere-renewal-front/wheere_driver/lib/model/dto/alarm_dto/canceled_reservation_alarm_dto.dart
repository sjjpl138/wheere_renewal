import 'package:wheere_driver/model/dto/alarm_dto/base_alarm_dto.dart';

import 'canceled_reservation_dto.dart';

class CanceledReservationAlarmDTO implements BaseAlarmDTO {
  @override
  String title;
  @override
  String body;
  @override
  String alarmType;
  @override
  String aTime;
  CanceledReservationDTO canceledReservationDTO;

  CanceledReservationAlarmDTO({
    required this.title,
    required this.body,
    required this.alarmType,
    required this.aTime,
    required this.canceledReservationDTO,
  });

  factory CanceledReservationAlarmDTO.fromJson(Map<String, dynamic> json) {
    return CanceledReservationAlarmDTO(
      title: json["title"],
      body: json["body"],
      alarmType: json["alarmType"],
      aTime: json["aTime"],
      canceledReservationDTO:
          CanceledReservationDTO.fromJson(json["canceledReservationDTO"] ?? json),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "alarmType": alarmType,
      "aTime": aTime,
      "canceledReservationDTO": canceledReservationDTO.toJson(),
    };
  }
}
