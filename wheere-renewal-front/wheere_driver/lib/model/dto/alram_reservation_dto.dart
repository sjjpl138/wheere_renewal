class AlramReservationDTO{
  String mId;
  String rId;
  String bId;
  int startSeq;
  int endSeq;

  AlramReservationDTO({
    required this.mId,
    required this.rId,
    required this.bId,
    required this.startSeq,
    required this.endSeq
  });

  factory AlramReservationDTO.fromJson(Map<String, dynamic> json) {
    return AlramReservationDTO(
      mId: json["mId"],
      rId: json["rId"],
      bId: json["bId"],
      startSeq: json["startSeq"],
      endSeq: json["endSeq"]
    );
  }
}