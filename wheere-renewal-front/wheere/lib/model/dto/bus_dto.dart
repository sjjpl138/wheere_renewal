class BusDTO {
  int bId;
  String bNo;
  int sStationId;
  String sStationName;
  String sTime;
  int eStationId;
  String eStationName;
  String eTime;
  String eWalkingTime;
  int leftSeats;

  BusDTO({
    required this.bId,
    required this.bNo,
    required this.sStationId,
    required this.sStationName,
    required this.sTime,
    required this.eStationId,
    required this.eStationName,
    required this.eTime,
    required this.eWalkingTime,
    required this.leftSeats,
  });
}