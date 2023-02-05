class BusRouteDTO {
  String bNo;
  List<String> bIdList;
  String sStationId;
  String sStationName;
  List<String> sTimeList;
  String eStationId;
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
      bIdList: json["bIdList"],
      sStationId: json["sStationId"],
      sStationName: json["sStationName"],
      sTimeList: json["sTimeList"],
      eStationId: json["eStationId"],
      eStationName: json["eStationName"],
      eTimeList: json["eTimeList"],
      leftSeatsList: json["leftSeatsList"],
    );
  }
}
