import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/view_model/type/types.dart';

class AlarmDTO {
  String alarmType;
  String mId;
  String rId;

  AlarmDTO({
    required this.alarmType,
    required this.mId,
    required this.rId,
  });

  factory AlarmDTO.fromJson(Map<String, dynamic> json) {
    return AlarmDTO(
      alarmType: json["alarmType"],
      mId: json["mId"],
      rId: json["rId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alarmType": alarmType,
      "mId": mId,
      "rId": rId,
    };
  }
}
