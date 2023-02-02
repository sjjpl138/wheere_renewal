import 'package:wheere/model/dto/dtos.dart';

class RatingAlarmDTO implements BaseAlarmDTO {
  @override
  String title;
  @override
  String body;
  @override
  String alarmType;
  @override
  String aTime;
  AlarmReservationDTO reservation;

  RatingAlarmDTO({
    required this.title,
    required this.body,
    required this.alarmType,
    required this.aTime,
    required this.reservation,
  });

  factory RatingAlarmDTO.fromJson(Map<String, dynamic> json) {
    return RatingAlarmDTO(
      title: json["title"],
      body: json["body"],
      alarmType: json["alarmType"],
      aTime: json["aTime"],
      reservation: AlarmReservationDTO.fromJson(json["reservation"] ?? json),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "alarmType": alarmType,
      "aTime": aTime,
      "reservation": reservation.toJson(),
    };
  }
}
