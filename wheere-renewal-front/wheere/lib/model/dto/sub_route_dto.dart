import 'bus_route_dto.dart';

class SubRouteDTO {
  int trafficType;
  int sectionTime;
  BusRouteDTO? busRoute; //일단 busdto로 보류

  SubRouteDTO({
    required this.trafficType,
    required this.sectionTime,
    required this.busRoute,
  });

  factory SubRouteDTO.fromJson(Map<String, dynamic> json) {
    if (json['busRoute'] != null) {
      return SubRouteDTO(
        trafficType: json['trafficType'],
        sectionTime: json['sectionTime'],
        busRoute: BusRouteDTO.fromJson(json['busRoute']),
      );
    } else {
      return SubRouteDTO(
        trafficType: json['trafficType'],
        sectionTime: json['sectionTime'],
        busRoute: null,
      );
    }
  }
}
