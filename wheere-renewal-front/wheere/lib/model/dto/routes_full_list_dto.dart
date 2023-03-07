import 'package:wheere/model/dto/dtos.dart';

class RouteFullListDTO {
  int outTrafficCheck;
  List<RouteDTO> routes;

  RouteFullListDTO({
    required this.outTrafficCheck,
    required this.routes,
  });

  factory RouteFullListDTO.fromJson(Map<String, dynamic> json) {
    var list = json['routes'] as List;
    List<RouteDTO> getList = list.map((i) => RouteDTO.fromJson(i)).toList();
    return RouteFullListDTO(
      outTrafficCheck: json['outTrafficCheck'],
      routes: getList,
    );
  }
}
