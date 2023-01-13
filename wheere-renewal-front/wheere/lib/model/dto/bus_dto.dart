class BusDTO {
  int bId;
  String bNo;
  String sWalkingTime;
  int sStationId;
  String sStationName;
  String sTime;
  int eStationId;
  String eStationName;
  String eTime;
  int leftSeats;

  BusDTO({
    required this.bId,
    required this.bNo,
    required this.sWalkingTime,
    required this.sStationId,
    required this.sStationName,
    required this.sTime,
    required this.eStationId,
    required this.eStationName,
    required this.eTime,
    required this.leftSeats,
  });
}