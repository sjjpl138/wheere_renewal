class ReservationData {
  final int rId;
  final int bId;
  final String bNo;
  final String vNo;
  final String routeId;
  final String rDate;
  final String sStationName;
  final String sStationTime;
  final String eStationName;
  final String eStationTime;


  const ReservationData({
    required this.rId,
    required this.bNo,
    required this.bId,
    required this.vNo,
    required this.rDate,
    required this.routeId,
    required this.sStationName,
    required this.sStationTime,
    required this.eStationName,
    required this.eStationTime,
  });
}
