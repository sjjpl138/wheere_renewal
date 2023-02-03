import 'package:wheere/model/dto/dtos.dart';
import 'package:wheere/model/dto/select_dto.dart';

class RouteFullListDTO {
  int outTrafficCheck;
  List<SelectDTO> selects;

  RouteFullListDTO({
    required this.outTrafficCheck,
    required this.selects,
  });

  factory RouteFullListDTO.fromJson(Map<String, dynamic> json) {
    var list = json['selects'] as List;
    List<SelectDTO> getList = list.map((i) => SelectDTO.fromJson(i)).toList();
    return RouteFullListDTO(
        outTrafficCheck: json['outTrafficCheck'],
        selects: getList);
  }
}