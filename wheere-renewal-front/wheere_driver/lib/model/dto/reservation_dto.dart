import 'package:wheere_driver/model/dto/member_dto.dart';

class ReservationDTO{
  MemberDTO member;
  int rId;
  String bId;
  int startSeq;
  int endSeq;

  ReservationDTO({
    required this.member,
    required this.rId,
    required this.bId,
    required this.startSeq,
    required this.endSeq
  });

  factory ReservationDTO.fromJson(Map<String, dynamic> json) {
    return ReservationDTO(
      member: MemberDTO.fromJson(json["member"]),
      rId: json["rId"],
      bId: json["bId"],
      startSeq: json["startSeq"],
      endSeq: json["endSeq"],
    );
  }
}