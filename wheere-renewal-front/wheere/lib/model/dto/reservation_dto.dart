class ReservationDTO {
  int rId;
  String routeId;
  String bNo;
  String rTime;
  int sStationId;
  String sStationName;
  String sTime;
  int eStationId;
  String eStationName;
  String eTime;

  ReservationDTO({
    required this.rId,
    required this.routeId,
    required this.bNo,
    required this.rTime,
    required this.sStationId,
    required this.sStationName,
    required this.sTime,
    required this.eStationId,
    required this.eStationName,
    required this.eTime,
  });

  factory ReservationDTO.fromJson(Map<String, dynamic> json) {
    return ReservationDTO(
      rId: json["rId"],
      routeId: json["routeId"],
      bNo: json['bNo'],
      rTime: json['rTime'],
      sStationId: json['sStationId'],
      sStationName: json['sStationName'],
      sTime: json['sTime'],
      eStationId: json['eStationId'],
      eStationName: json['eStationName'],
      eTime: json['eTime'],
    );
  }
}
