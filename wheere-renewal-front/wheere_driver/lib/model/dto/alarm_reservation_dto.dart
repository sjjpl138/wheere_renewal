class AlarmReservationDTO{
  String mId;
  String rId;
  String bId;
  int startSeq;
  int endSeq;

  AlarmReservationDTO({
    required this.mId,
    required this.rId,
    required this.bId,
    required this.startSeq,
    required this.endSeq
  });

  factory AlarmReservationDTO.fromJson(Map<String, dynamic> json) {
    return AlarmReservationDTO(
      mId: json["mId"],
      rId: json["rId"],
      bId: json["bId"],
      startSeq: json["startSeq"],
      endSeq: json["endSeq"]
    );
  }
}