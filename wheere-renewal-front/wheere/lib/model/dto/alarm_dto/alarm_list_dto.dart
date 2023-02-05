import 'dart:developer';

import 'base_alarm_dto.dart';

class AlarmListDTO {
  List<BaseAlarmDTO> alarms;

  AlarmListDTO({
    required this.alarms,
  });

  factory AlarmListDTO.fromJson(Map<String, dynamic> data) {
    log(data["alarms"].toString());
    return AlarmListDTO(
      alarms: (data['alarms'] as List)
          .map((i) => BaseAlarmDTO.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alarms": alarms.map((i) => i.toJson()).toList(),
    };
  }
}
