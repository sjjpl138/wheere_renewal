import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/dto/routes_by_hours_dto.dart';

class RouteFullListDTO {
  List<RoutesByHoursDTO> routeFullList;

  RouteFullListDTO({
    required this.routeFullList,
  });

  factory RouteFullListDTO.fromJson(Map<String, dynamic> json) {
    var list = json['selects'] as List;
    List<RoutesByHoursDTO> getList = list.map((i) => RoutesByHoursDTO.fromJson(i)).toList();
    return RouteFullListDTO(routeFullList: getList);
  }
}