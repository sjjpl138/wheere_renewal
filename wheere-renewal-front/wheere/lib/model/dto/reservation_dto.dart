class ReservationDTO {
  int rId;
  String rDate;
  String bNo;
  String routeId;
  String vNo;
  int sStationId;
  String sStationName;
  int eStationId;
  String eStationName;
  String rState;
  String sTime;
  String eTime;

  ReservationDTO({
    required this.rId,
    required this.rDate,
    required this.bNo,
    required this.routeId,
    required this.vNo,
    required this.sStationId,
    required this.sStationName,
    required this.eStationId,
    required this.eStationName,
    required this.rState,
    required this.sTime,
    required this.eTime,
  });

  factory ReservationDTO.fromJson(Map<String, dynamic> json) {
    return ReservationDTO(
      rId: json['rId'],
      rDate: json['rDate'],
      bNo: json['bNo'],
      routeId: json['routeId'],
      vNo: json['vNo'],
      sStationId: json['sStationId'],
      sStationName: json['sStationName'],
      eStationId: json['eStationId'],
      eStationName: json['eStationName'],
      rState: json['rState'],
      sTime: json['sTime'],
      eTime: json['eTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "rId": rId,
      "rDate": rDate,
      "bNo": bNo,
      "routeId": routeId,
      "vNo": vNo,
      "sStationId": sStationId,
      "sStationName": sStationName,
      "eStationId": eStationId,
      "eStationName": eStationName,
      "rState": rState,
      "sTime": sTime,
      "eTime": eTime,
    };
  }
}
