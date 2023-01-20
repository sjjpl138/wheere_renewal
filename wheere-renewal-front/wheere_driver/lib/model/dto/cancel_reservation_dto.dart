class CancelReservationDTO{
  String mId;
  String rId;

  CancelReservationDTO({
    required this.mId,
    required this.rId,
  });

  factory CancelReservationDTO.fromJson(Map<String, dynamic> json) {
    return CancelReservationDTO(
        mId: json["mId"],
        rId: json["rId"],
    );
  }
}