import 'package:wheere/model/dto/dtos.dart';

class AlarmDTO {
  String alarmType;
  String aTime;
  AlramReservationDTO reservation;

  AlarmDTO({
    required this.alarmType,
    required this.aTime,
    required this.reservation,
  });

  factory AlarmDTO.fromJson(Map<String, dynamic> json) {
    return AlarmDTO(
      alarmType: json["alarmType"],
      aTime: json["aTime"],
      reservation: AlramReservationDTO.fromJson(json["reservation"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alarmType": alarmType,
      "aTime": aTime,
      "reservation": reservation.toJson(),
    };
  }
}
