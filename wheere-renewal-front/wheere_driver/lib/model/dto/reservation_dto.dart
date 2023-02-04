import 'package:wheere_driver/model/dto/dtos.dart';

class ReservationDTO {
  MemberDTO member;
  String rId;
  String bId;
  int startSeq;
  int endSeq;

  @override
  int get hashCode => rId.hashCode;

  @override
  bool operator ==(covariant ReservationDTO other) =>
      rId.compareTo(other.rId) == 0;

  ReservationDTO(
      {required this.member,
      required this.rId,
      required this.bId,
      required this.startSeq,
      required this.endSeq});

  factory ReservationDTO.fromJson(Map<String, dynamic> json) {
    return ReservationDTO(
      member: MemberDTO.fromJson(json["member"]),
      rId: json["rId"],
      bId: json["bId"],
      startSeq: json["startSeq"],
      endSeq: json["endSeq"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "member": member.toJson(),
      "rId": rId,
      "bId": bId,
      "startSeq": startSeq,
      "endSeq": endSeq,
    };
  }
}

