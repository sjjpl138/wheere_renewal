class RequestReservationBusDTO{
  int bId;
  int sStationId;
  int eStationId;

  RequestReservationBusDTO({
    required this.bId,
    required this.sStationId,
    required this.eStationId
  });

  Map<String, dynamic> toJson() => {
    'bId': bId,
    'sStationId': sStationId,
    'eStationId': eStationId,
  };
}