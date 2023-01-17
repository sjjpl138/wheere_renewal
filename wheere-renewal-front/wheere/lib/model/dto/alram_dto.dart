import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view_model/type/types.dart';

class AlarmDTO {
  String mId;
  AlarmType alarmType;
  ReservationDTO reservation;

  AlarmDTO({
    required this.mId,
    required this.alarmType,
    required this.reservation,
  });

  factory AlarmDTO.fromJson(Map<String, dynamic> json) {
    return AlarmDTO(
        mId: json["mId"],
        alarmType: json["alarmType"],
        reservation: ReservationDTO.fromJson(
            json["reservation"] as Map<String, dynamic>));
  }
}
