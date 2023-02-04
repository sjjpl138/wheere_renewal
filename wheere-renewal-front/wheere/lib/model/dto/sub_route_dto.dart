import 'bus_dto.dart';

class SubRouteDTO{
  int trafficType;
  int sectionTime;
  List<BusDTO>? busRoute; //일단 busdto로 보류

  SubRouteDTO({
    required this.trafficType,
    required this.sectionTime,
    required this.busRoute
  });

  factory SubRouteDTO.fromJson(Map<String, dynamic> json) {
    if (json['busRoute'] != null) {
      var list = json['busRoute'] as List;
      List<BusDTO> getList = list.map((i) => BusDTO.fromJson(i)).toList();
      return SubRouteDTO(
          trafficType: json['trafficType'],
          sectionTime: json['sectionTime'],
          busRoute: getList
      );
    }
    else {
      return SubRouteDTO(
          trafficType: json['trafficType'],
          sectionTime: json['sectionTime'],
          busRoute: null
      );
    }
  }
}