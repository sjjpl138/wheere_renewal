class NewReservationDTO{
  String mId;
  String rId;
  String bId;
  int startSeq;
  int endSeq;

  NewReservationDTO({
    required this.mId,
    required this.rId,
    required this.bId,
    required this.startSeq,
    required this.endSeq
  });

  factory NewReservationDTO.fromJson(Map<String, dynamic> json) {
    return NewReservationDTO(
      mId: json["mId"],
      rId: json["rId"],
      bId: json["bId"],
      startSeq: json["startSeq"],
      endSeq: json["endSeq"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mId": mId,
      "rId": rId,
      "bId": bId,
      "startSeq": startSeq,
      "endSeq": endSeq,
    };
  }
}