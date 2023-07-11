import 'package:wheere_driver/model/dto/dtos.dart';

class ReservationDTO {
  MemberDTO member;
  String rId;
  int bId;
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
    print(json);
    return ReservationDTO(
      member: MemberDTO.fromJson(json["member"] ?? json),
      rId: json["rId"] is String? json["rId"] : json["rId"].toString(),
      bId: json["bid"] is int ? json["bid"] : int.parse(json["bid"]),
      startSeq: json["startSeq"] is int ? json["startSeq"] :int.parse(json["startSeq"]),
      endSeq: json["endSeq"] is int ? json["endSeq"] :int.parse(json["endSeq"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "member": member.toJson(),
      "rId": rId,
      "bid": bId,
      "startSeq": startSeq,
      "endSeq": endSeq,
    };
  }
}

