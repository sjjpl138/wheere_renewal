import 'alarm_member_dto.dart';

class NewReservationDTO{
  AlarmMemberDTO alarmMemberDTO;
  String rId;
  String bId;
  int startSeq;
  int endSeq;

  NewReservationDTO({
    required this.alarmMemberDTO,
    required this.rId,
    required this.bId,
    required this.startSeq,
    required this.endSeq
  });

  factory NewReservationDTO.fromJson(Map<String, dynamic> json) {
    return NewReservationDTO(
      alarmMemberDTO: AlarmMemberDTO.fromJson(json["alarmMemberDTO"]),
      rId: json["rId"],
      bId: json["bId"],
      startSeq: json["startSeq"],
      endSeq: json["endSeq"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alarmMemberDTO": alarmMemberDTO.toJson(),
      "rId": rId,
      "bId": bId,
      "startSeq": startSeq,
      "endSeq": endSeq,
    };
  }
}