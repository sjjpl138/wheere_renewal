class AlarmReservationDTO{
  String rId;
  String rDate;
  String bNo;
  String sTime;
  String sStationName;
  String eTime;
  String eStationName;

  factory AlarmReservationDTO.fromJson(Map<String, dynamic> json) {
    return AlarmReservationDTO(
      rId: json['rId'],
      rDate: json['rDate'],
      bNo: json['bNo'],
      sStationName: json['sStationName'],
      eStationName: json['eStationName'],
      sTime: json['sTime'],
      eTime: json['eTime']
    );
  }

  AlarmReservationDTO({
    required this.rId,
    required this.rDate,
    required this.bNo,
    required this.sStationName,
    required this.eStationName,
    required this.sTime,
    required this.eTime
  });

  Map<String, dynamic> toJson() {
    return {
      "rId": rId,
      "rDate": rDate,
      "bNo": bNo,
      "sStationName": sStationName,
      "eStationName": eStationName,
      "sTime": sTime,
      "eTime": eTime,
    };
  }

}