class CanceledReservationDTO {
  String mId;
  int rId;

  CanceledReservationDTO({
    required this.mId,
    required this.rId,
  });

  factory CanceledReservationDTO.fromJson(Map<String, dynamic> json) {
    return CanceledReservationDTO(
      mId: json["mId"],
      rId: json["rId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mId": mId,
      "rId": rId,
    };
  }
}
