class BusesDTO{
  int bNo;
  String routeId;
  String vNo;
  String sTime;
  String sStationId;
  String sStationName;
  String eTime;
  String eStationId;
  String eStationName;

  BusesDTO({
    required this.bNo,
    required this.routeId,
    required this.vNo,
    required this.sTime,
    required this.sStationId,
    required this.sStationName,
    required this.eTime,
    required this.eStationId,
    required this.eStationName
  });

  factory BusesDTO.fromJson(Map<String, dynamic> json) {
    return BusesDTO(
      bNo: json['bNo'],
      routeId: json['routeId'],
      vNo: json['vNo'],
      sTime: json['sTime'],
      sStationId: json['sStationId'],
      sStationName: json['sStationName'],
      eTime: json['eTime'],
      eStationId: json['eStationId'],
      eStationName: json['eStationName']
    );
  }
}