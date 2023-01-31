import 'package:wheere_driver/model/dto/dtos.dart';

class NewReservationDTO{
  MemberDTO memberDTO;
  String rId;
  String bId;
  int startSeq;
  int endSeq;

  NewReservationDTO({
    required this.memberDTO,
    required this.rId,
    required this.bId,
    required this.startSeq,
    required this.endSeq
  });

  factory NewReservationDTO.fromJson(Map<String, dynamic> json) {
    return NewReservationDTO(
      memberDTO: MemberDTO.fromJson(json["alarmMemberDTO"]),
      rId: json["rId"],
      bId: json["bId"],
      startSeq: json["startSeq"],
      endSeq: json["endSeq"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alarmMemberDTO": memberDTO.toJson(),
      "rId": rId,
      "bId": bId,
      "startSeq": startSeq,
      "endSeq": endSeq,
    };
  }
}