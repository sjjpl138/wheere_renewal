import 'dart:convert';

import 'alarm_dto.dart';

class AlarmTestListDTO {
  List<String> alarms;

  AlarmTestListDTO({
    required this.alarms,
  });

  factory AlarmTestListDTO.fromJson(Map<String, dynamic> json) {
    return AlarmTestListDTO(
      alarms:
      (json['alarms'] as List).map((i) => i.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alarms": alarms.map((i) => i.toString()).toList(),
    };
  }
}
