import 'package:wheere_driver/model/dto/alarm_dto/base_alarm_dto.dart';
import 'package:wheere_driver/model/dto/alarm_dto/new_reservation_dto.dart';

class NewReservationAlarmDTO implements BaseAlarmDTO {
  @override
  String title;
  @override
  String body;
  @override
  String alarmType;
  @override
  String aTime;
  NewReservationDTO newReservationDTO;

  NewReservationAlarmDTO({
    required this.title,
    required this.body,
    required this.alarmType,
    required this.aTime,
    required this.newReservationDTO,
  });

  factory NewReservationAlarmDTO.fromJson(Map<String, dynamic> json) {
    return NewReservationAlarmDTO(
      title: json["title"],
      body: json["body"],
      alarmType: json["alarmType"],
      aTime: json["aTime"],
      newReservationDTO:
      NewReservationDTO.fromJson(json["newReservationDTO"]),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "alarmType": alarmType,
      "aTime": aTime,
      "newReservationDTO": newReservationDTO.toJson(),
    };
  }
}
