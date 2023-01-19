import 'bus_dto.dart';

class RouteDTO {
  String sWalkingTime;
  List<BusDTO> buses;

  RouteDTO({
    required this.buses,
    required this.sWalkingTime,
  });

  factory RouteDTO.fromJson(Map<String, dynamic> json) {
    var list = json['buses'] as List;
    List<BusDTO> getList = list.map((i) => BusDTO.fromJson(i)).toList();
    return RouteDTO(
      sWalkingTime: json['sWalkingTime'],
      buses: getList
    );
  }
}