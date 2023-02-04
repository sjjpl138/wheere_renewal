
import 'base_alarm_dto.dart';

class TestAlarmDTO implements BaseAlarmDTO {
  @override
  String title;
  @override
  String body;
  @override
  String alarmType;
  @override
  String aTime;
  String data;

  TestAlarmDTO({
    required this.title,
    required this.body,
    required this.alarmType,
    required this.aTime,
    required this.data,
  });

  factory TestAlarmDTO.fromJson(Map<String, dynamic> json) {
    return TestAlarmDTO(
      title: json["title"],
      body: json["body"],
      alarmType: json["alarmType"],
      aTime: json["aTime"],
      data: json.toString(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "alarmType": alarmType,
      "aTime": aTime,
      "data": data,
    };
  }
}
