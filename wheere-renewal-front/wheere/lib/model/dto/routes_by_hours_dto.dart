import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/dto/route_dto.dart';

class RoutesByHoursDTO {
  String selectTime;
  List<RouteDTO> routes;

  RoutesByHoursDTO({
    required this.selectTime,
    required this.routes,
  });

  factory RoutesByHoursDTO.fromJson(Map<String, dynamic> json) {
    var list = json['routes'] as List;
    List<RouteDTO> getList = list.map((i) => RouteDTO.fromJson(i)).toList();
    return RoutesByHoursDTO(
        selectTime: json['selectTime'],
        routes: getList
    );
  }
}