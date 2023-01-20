class ReservationDTO{
  int rId;
  int startSeq;
  int endSeq;

  ReservationDTO({
    required this.rId,
    required this.startSeq,
    required this.endSeq
  });

  factory ReservationDTO.fromJson(Map<String, dynamic> json) {
    return ReservationDTO(
      rId: json["rId"],
      startSeq: json["startSeq"],
      endSeq: json["endSeq"],
    );
  }
}