class BusData {
  String bId;
  String bNo;
  String sStationId;
  String sStationName;
  String sTime;
  String eStationId;
  String eStationName;
  String eTime;
  String eWalkingTime;
  int leftSeats;

  BusData({
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

  factory BusData.fromJson(Map<String, dynamic> json) {
    return BusData(
      bId: json['bId'],
      bNo: json['bNo'],
      sStationId: json['sStationId'],
      sStationName: json['sStationName'],
      sTime: json['sTime'],
      eStationId: json['eStationId'],
      eStationName: json['eStationName'],
      eTime: json['eTime'],
      eWalkingTime: json['eWalkingTime'],
      leftSeats: json['leftSeats'],
    );
  }

}