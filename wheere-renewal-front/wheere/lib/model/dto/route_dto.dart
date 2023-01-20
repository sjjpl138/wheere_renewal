import 'bus_dto.dart';

class RouteDTO {
  int payment;
  String sWalkingTime;
  List<BusDTO> buses;

  RouteDTO({
    required this.payment,
    required this.buses,
    required this.sWalkingTime,
  });

  factory RouteDTO.fromJson(Map<String, dynamic> json) {
    var list = json['buses'] as List;
    List<BusDTO> getList = list.map((i) => BusDTO.fromJson(i)).toList();
    return RouteDTO(
      payment: json['payment'],
      sWalkingTime: json['sWalkingTime'],
      buses: getList
    );
  }
}