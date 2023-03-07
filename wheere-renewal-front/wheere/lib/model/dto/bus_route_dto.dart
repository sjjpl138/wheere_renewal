class BusRouteDTO {
  String bNo;
  List<int> bIdList;
  int sStationId;
  String sStationName;
  List<String> sTimeList;
  int eStationId;
  String eStationName;
  List<String> eTimeList;
  List<int> leftSeatsList;

  BusRouteDTO({
    required this.bNo,
    required this.bIdList,
    required this.sStationId,
    required this.sStationName,
    required this.sTimeList,
    required this.eStationId,
    required this.eStationName,
    required this.eTimeList,
    required this.leftSeatsList,
  });

  factory BusRouteDTO.fromJson(Map<String, dynamic> json) {
    return BusRouteDTO(
      bNo: json["bNo"],
      bIdList: json["busId"].cast<int>(),
      sStationId: json["sStationId"],
      sStationName: json["sStationName"],
      sTimeList: json["sTime"].cast<String>(),
      eStationId: json["eStationId"],
      eStationName: json["eStationName"],
      eTimeList: json["eTime"].cast<String>(),
      leftSeatsList: json["leftSeats"].cast<int>(),
    );
  }
}
