import 'dart:convert';

import 'alarm_dto.dart';

class AlarmListDTO {
  List<AlarmDTO> alarms;

  AlarmListDTO({
    required this.alarms,
  });

  factory AlarmListDTO.fromJson(Map<String, dynamic> json) {
    return AlarmListDTO(
      alarms:
          (json['alarms'] as List).map((i) => AlarmDTO.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alarms": alarms.map((i) => i.toJson()).toList(),
    };
  }
}
