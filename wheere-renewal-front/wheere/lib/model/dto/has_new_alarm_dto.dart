class HasNewAlarmDTO {
  bool hasNewAlarm;

  HasNewAlarmDTO({
    required this.hasNewAlarm,
  });

  factory HasNewAlarmDTO.fromJson(Map<String, dynamic> json) {
    return HasNewAlarmDTO(
      hasNewAlarm: json["hasNewAlarm"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hasNewAlarm": hasNewAlarm,
    };
  }
}
