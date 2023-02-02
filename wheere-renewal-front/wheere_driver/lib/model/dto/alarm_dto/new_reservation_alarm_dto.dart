import 'package:wheere_driver/model/dto/alarm_dto/base_alarm_dto.dart';
import 'package:wheere_driver/model/dto/dtos.dart';

class NewReservationAlarmDTO implements BaseAlarmDTO {
  @override
  String title;
  @override
  String body;
  @override
  String alarmType;
  @override
  String aTime;
  ReservationDTO reservationDTO;

  NewReservationAlarmDTO({
    required this.title,
    required this.body,
    required this.alarmType,
    required this.aTime,
    required this.reservationDTO,
  });

  factory NewReservationAlarmDTO.fromJson(Map<String, dynamic> json) {
    return NewReservationAlarmDTO(
      title: json["title"],
      body: json["body"],
      alarmType: json["alarmType"],
      aTime: json["aTime"],
      reservationDTO:
      ReservationDTO.fromJson(json["newReservationDTO"] ?? json),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "alarmType": alarmType,
      "aTime": aTime,
      "newReservationDTO": reservationDTO.toJson(),
    };
  }
}
