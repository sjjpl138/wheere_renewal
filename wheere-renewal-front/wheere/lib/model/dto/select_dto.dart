import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/dto/route_dto.dart';

class SelectDTO {
  String selectTime;
  List<RouteDTO> routes;

  SelectDTO({
    required this.selectTime,
    required this.routes,
  });

  factory SelectDTO.fromJson(Map<String, dynamic> json) {
    var list = json['routes'] as List;
    List<RouteDTO> getList = list.map((i) => RouteDTO.fromJson(i)).toList();
    return SelectDTO(
        selectTime: json['selectTime'],
        routes: getList
    );
  }
}