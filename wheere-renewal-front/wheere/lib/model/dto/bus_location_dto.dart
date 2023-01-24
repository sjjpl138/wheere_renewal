import 'station_list_dto.dart';

class BusLocationDTO{
  int rId; //노선 번호
  int stationNo; // 정류소 순서
  String stationName; //정류소명
  String sId; //정류소 ID
  String vNo; //차량 번호
  StationListDTO? stations;

  BusLocationDTO({
    required this.rId,
    required this.stationNo,
    required this.stationName,
    required this.sId,
    required this.vNo,
  });

  factory BusLocationDTO.fromJson(Map<String, dynamic> json) {
    return BusLocationDTO(
        rId: json['routenm'],
        stationNo: json['nodeord'],
        stationName: json['nodenm'],
        sId: json['nodeie'],
        vNo: json['vehicleno']);
  }


}