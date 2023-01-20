class RequestReservationBusDTO{
  int dId;
  int sStationId;
  int eStationId;

  RequestReservationBusDTO({
    required this.dId,
    required this.sStationId,
    required this.eStationId
  });

  Map<String, dynamic> toJson() => {
    'dId': dId,
    'sStationId': sStationId,
    'eStationId': eStationId,
  };
}