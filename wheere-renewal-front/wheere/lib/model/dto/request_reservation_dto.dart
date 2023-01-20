class RequestReservationDTO {
  String mId;
  int bId;
  int sStationId;
  int eStationId;
  String rDate;

  RequestReservationDTO({
    required this.mId,
    required this.bId,
    required this.sStationId,
    required this.eStationId,
    required this.rDate
  });

  Map<String, dynamic> toJson() => {
    'mId': mId,
    'bId': bId,
    'sStationId': sStationId,
    'eStationId': eStationId,
    'rDate': rDate
  };
}